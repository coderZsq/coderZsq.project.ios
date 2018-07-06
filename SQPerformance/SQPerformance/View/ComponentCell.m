//
//  ComponentCell.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ComponentCell.h"
#import "ComponentLayout.h"
#import "Element.h"
#import "ReusePool.h"
#import "AsyncDrawLayer.h"

@interface ComponentCell ()

@property (nonatomic,strong) ReusePool * labelReusePool;
@property (nonatomic,strong) ReusePool * imageReusePool;
@property (nonatomic,strong) ReusePool * asyncReusePool;

@property (nonatomic,weak) AsyncDrawLayer * drawLayer;
@property (nonatomic,strong) ComponentLayout * layout;
@property (nonatomic,assign, getter=isAsynchronously) BOOL asynchronously;

@end

@interface UIImage (Extension)
- (UIImage *)cornerRadius:(CGFloat)cornerRadius;
@end

@implementation ComponentCell

- (void)dealloc {
#if DEBUG
    NSLog(@"--------");
    NSLog(@"%@ - execute %s",NSStringFromClass([self class]),__func__);
    NSLog(@"--------");
#endif
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * identifier = NSStringFromClass([ComponentCell class]);
    ComponentCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ComponentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupConfig];
    }
    return cell;
}

- (void)setupConfig {
    self.opaque = NO;
    self.layer.contentsScale = [[UIScreen mainScreen] scale];
    if ([self.layer isKindOfClass:[AsyncDrawLayer class]]) {
        _drawLayer = (AsyncDrawLayer *)self.layer;
    }
    _labelReusePool = [ReusePool new];
    _imageReusePool = [ReusePool new];
    _asyncReusePool = [ReusePool new];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
}

+ (Class)layerClass {
    return [AsyncDrawLayer class];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    if (!self.layer.contents) {
        [self setNeedsDisplay];
    }
}

- (void)setNeedsDisplay {
    [self.layer setNeedsDisplay];
}

- (void)setNeedsDisplayInRect:(CGRect)rect {
    [self.layer setNeedsDisplayInRect:rect];
}

- (void)displayLayer:(CALayer *)layer {
    
    if (!layer) return;
    if (layer != self.layer) return;
    if (![layer isKindOfClass:[AsyncDrawLayer class]]) return;
    if (!self.isAsynchronously) return;

    AsyncDrawLayer * tempLayer = (AsyncDrawLayer *)layer;
    [tempLayer increaseCount];
    
    NSUInteger oldCount = tempLayer.drawsCount;
    CGRect bounds = self.bounds;
    UIColor * backgroundColor = self.backgroundColor;
    
    void (^drawBlock)(void) = ^{
        void (^failedBlock)(void) = ^{
            
        };
        if (tempLayer.drawsCount != oldCount) {
            failedBlock();
            return;
        }
        CGSize contextSize = layer.bounds.size;
        BOOL contextSizeValid = contextSize.width >= 1 && contextSize.height > 1;
        CGContextRef context = NULL;
        BOOL drawingFinished = YES;
        
        if (contextSizeValid) {
            UIGraphicsBeginImageContextWithOptions(contextSize, layer.isOpaque, layer.contentsScale);
            context = UIGraphicsGetCurrentContext();
            CGContextSaveGState(context);
            if (bounds.origin.x || bounds.origin.y) {
                CGContextTranslateCTM(context, self.bounds.origin.x, -self.bounds.origin.y);
            }
            if (tempLayer.drawsCount != oldCount) {
                drawingFinished = NO;
            } else {
                if (backgroundColor && backgroundColor != [UIColor clearColor]) {
                    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
                    CGContextFillRect(context, bounds);
                }
                drawingFinished = [self asyncDraw:YES context:context];
            }
            CGContextRestoreGState(context);
        }
        if (drawingFinished && oldCount == tempLayer.drawsCount) {
            CGImageRef cgImage = context ? CGBitmapContextCreateImage(context) : NULL;
            {
                UIImage * image = cgImage ? [UIImage imageWithCGImage:cgImage] : nil;
                
                void (^finishBlock)(void) = ^{
                    if (oldCount != tempLayer.drawsCount) {
                        failedBlock();
                        return;
                    }
                    layer.contents = (id)image.CGImage;
                    layer.opacity = 0.0;
                    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                        layer.opacity = 1.0;
                    } completion:NULL];
                };
                dispatch_async(dispatch_get_main_queue(), finishBlock);
            }
            if (cgImage) {
                CGImageRelease(cgImage);
            }
        } else {
            failedBlock();
        }
        UIGraphicsEndImageContext();
    };
    layer.contents = nil;
    dispatch_async(dispatch_get_global_queue(0, 0), drawBlock);
}

- (void)setupData:(ComponentLayout *)layout asynchronously:(BOOL)asynchronously {
    _layout = layout; _asynchronously = asynchronously;
    
    if (asynchronously) {
        [self setNeedsDisplay];
        return;
    } else {
        self.layer.contents = nil;
    }

    for (Element * element in layout.textElements) {
        UILabel * label = (UILabel *)[_labelReusePool dequeueReusableObject];
        if (!label) {
            label = [UILabel new];
            [_labelReusePool addUsingObject:label];
        }
        label.text = element.value;
        label.frame = element.frame;
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
    }
    [_labelReusePool reset];

    for (Element * element in layout.imageElements) {
        UIImageView * imageView = (UIImageView *)[_imageReusePool dequeueReusableObject];
        if (!imageView) {
            imageView = [UIImageView new];
            [_imageReusePool addUsingObject:imageView];
        }
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIImage * image = [self preDecodeFrom:element.value];
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = image;
            });
        });
        imageView.frame = element.frame;
        [self.contentView addSubview:imageView];
    }
    [_imageReusePool reset];
}

- (UIImage *)preDecodeFrom:(NSString *)url {
    
    CGImageRef cgImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]].CGImage;
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(cgImage) & kCGBitmapAlphaInfoMask;
    
    BOOL hasAlpha = NO;
    if (alphaInfo == kCGImageAlphaPremultipliedLast ||
        alphaInfo == kCGImageAlphaPremultipliedFirst ||
        alphaInfo == kCGImageAlphaLast ||
        alphaInfo == kCGImageAlphaFirst) {
        hasAlpha = YES;
    }
    
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
    bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;
    
    size_t width = CGImageGetWidth(cgImage);
    size_t height = CGImageGetHeight(cgImage);
    
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, CGColorSpaceCreateDeviceRGB(), bitmapInfo);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgImage);
    cgImage = CGBitmapContextCreateImage(context);
    
    UIImage * image = [[UIImage imageWithCGImage:cgImage] cornerRadius:width * 0.5];
    CGContextRelease(context);
    CGImageRelease(cgImage);
    return image;
}

- (BOOL)asyncDraw:(BOOL)asynchronously context:(CGContextRef)context {

    for (Element * element in _layout.textElements) {
        NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [element.value drawInRect:element.frame withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                                                 NSForegroundColorAttributeName:[UIColor blackColor],
                                                                 NSParagraphStyleAttributeName:paragraphStyle}];
    }

    for (Element * element in _layout.imageElements) {
        UIImage * image = (UIImage *)[_asyncReusePool dequeueReusableObject];
        if (!image) {
            image = [self preDecodeFrom:element.value];
            [_asyncReusePool addUsingObject:image];
        }
        [image drawInRect:element.frame];
    }
    [_asyncReusePool reset];

    return YES;
}

@end

@implementation UIImage (Extension)

- (UIImage *)cornerRadius:(CGFloat)cornerRadius {
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    UIGraphicsBeginImageContextWithOptions(self.size, false, [UIScreen mainScreen].scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), bezierPath.CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
