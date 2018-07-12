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
#import "PermenantThread.h"

@interface ComponentCell ()

@property (nonatomic,strong) ReusePool * labelReusePool;
@property (nonatomic,strong) ReusePool * imageReusePool;
@property (class, nonatomic,strong) ReusePool * asyncReusePool;

@property (nonatomic,weak) AsyncDrawLayer * drawLayer;
@property (nonatomic,strong) ComponentLayout * layout;
@property (nonatomic,assign, getter=isAsynchronously) BOOL asynchronously;

@property (nonatomic,strong) PermenantThread * thread;

@end

@interface UIImage (Extension)
- (UIImage *)cornerRadius:(CGFloat)cornerRadius;
@end

@interface NSString (Extension)
- (void)preDecode:(void(^)(UIImage *))completion;
@end

@implementation ComponentCell

static ReusePool * _asyncReusePool = nil;

+ (ReusePool *)asyncReusePool {
    if (_asyncReusePool == nil) {
        _asyncReusePool = [[ReusePool alloc] init];
    }
    return _asyncReusePool;
}

+ (void)setAsyncReusePool:(ReusePool *)asyncReusePool {
    if (_asyncReusePool != asyncReusePool) {
        _asyncReusePool = asyncReusePool;
    }
}

- (void)dealloc {
    [_thread stop];
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
    _thread = [PermenantThread new];
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

- (void)drawRect:(CGRect)rect {}

- (void)displayLayer:(CALayer *)layer {
    
    if (!layer) return;
    if (layer != self.layer) return;
    if (![layer isKindOfClass:[AsyncDrawLayer class]]) return;
    if (!self.isAsynchronously) return;
    
    AsyncDrawLayer *tempLayer = (AsyncDrawLayer *)layer;
    [tempLayer increaseCount];
    
    NSUInteger oldCount = tempLayer.drawsCount;
    CGRect bounds = self.bounds;
    UIColor * backgroundColor = self.backgroundColor;
    
    layer.contents = nil;
    [_thread executeTask:^{
        void (^failedBlock)(void) = ^{
            NSLog(@"displayLayer failed");
        };
        if (tempLayer.drawsCount != oldCount) {
            failedBlock();
            return;
        }
        
        CGSize contextSize = layer.bounds.size;
        BOOL contextSizeValid = contextSize.width >= 1 && contextSize.height >= 1;
        
        if (contextSizeValid) {
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGContextRef context = CGBitmapContextCreate(NULL, contextSize.width, contextSize.height, 8, contextSize.width * 4, colorSpace, kCGImageAlphaPremultipliedFirst | kCGImageByteOrderDefault);
            CGColorSpaceRelease(colorSpace);
            CGAffineTransform normalState = CGContextGetCTM(context);
            CGContextTranslateCTM(context, 0, bounds.size.height);
            CGContextScaleCTM(context, 1, -1);
            CGContextConcatCTM(context, normalState);
            if (backgroundColor && backgroundColor != [UIColor clearColor]) {
                CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
                CGContextFillRect(context, bounds);
            }
            UIGraphicsPushContext(context);
            [self asyncDraw:YES context:context completion:^(BOOL drawingFinished) {
                if (drawingFinished && oldCount == tempLayer.drawsCount) {
                    CGImageRef CGImage = context ? CGBitmapContextCreateImage(context) : NULL;
                    {
                        UIImage * image = CGImage ? [UIImage imageWithCGImage:CGImage] : nil;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (oldCount != tempLayer.drawsCount) {
                                failedBlock();
                                return;
                            }
                            layer.contents = (id)image.CGImage;
                            layer.opacity = 0.0;
                            [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                                layer.opacity = 1.0;
                            } completion:NULL];
                        });
                    }
                    if (CGImage) {
                        CGImageRelease(CGImage);
                    }
                } else {
                    failedBlock();
                }
            }];
        }
        UIGraphicsPopContext();
    }];
}

- (void)setupData:(ComponentLayout *)layout asynchronously:(BOOL)asynchronously {
    _layout = layout; _asynchronously = asynchronously;
    
    if (!asynchronously) {
        for (Element * element in layout.textElements) {
            UILabel * label = (UILabel *)[_labelReusePool dequeueReusableObject];
            if (!label) {
                label = [UILabel new];
                [_labelReusePool addUsingObject:label];
            }
            label.text = element.value;
            label.frame = element.frame;
            label.font = [UIFont systemFontOfSize:7];
            [self.contentView addSubview:label];
        }
        [_labelReusePool reset];
        
        for (Element * element in _layout.imageElements) {
            UIImageView * imageView = (UIImageView *)[_imageReusePool dequeueReusableObject];
            if (!imageView) {
                imageView = [UIImageView new];
                [_imageReusePool addUsingObject:imageView];
            }
            UIImage * image = (UIImage *)[ComponentCell.asyncReusePool dequeueReusableObject];
            if (!image) {
                NSString * url = element.value;
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [url preDecode:^(UIImage * image) {
                        [ComponentCell.asyncReusePool addUsingObject:image];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            imageView.image = image;
                        });
                    }];
                });
            } else {
                imageView.image = image;
            }
            imageView.frame = element.frame;
            [self.contentView addSubview:imageView];
        }
        [ComponentCell.asyncReusePool reset];
        [_imageReusePool reset];
    }
}

- (void)asyncDraw:(BOOL)asynchronously context:(CGContextRef)context completion:(void(^)(BOOL))completion {
    
    for (Element * element in _layout.textElements) {
        NSMutableParagraphStyle * paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [element.value drawInRect:element.frame withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:7],
                                                                 NSForegroundColorAttributeName:[UIColor blackColor],
                                                                 NSParagraphStyleAttributeName:paragraphStyle}];
    }
    completion(YES);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
    for (Element * element in _layout.imageElements) {
        UIImage * image = (UIImage *)[ComponentCell.asyncReusePool dequeueReusableObject];
        if (!image) {
            dispatch_group_enter(group);
            dispatch_group_async(group, concurrentQueue, ^{
                NSString * url = element.value;
                [url preDecode:^(UIImage * image) {
                    [ComponentCell.asyncReusePool addUsingObject:image];
                    CGContextDrawImage(context, element.frame, image.CGImage);
                }];
                dispatch_group_leave(group);
            });
        } else {
            [image drawInRect:element.frame];
            completion(YES);
        }
    }
    dispatch_group_notify(group, concurrentQueue, ^{
        completion(YES);
    });
    [_asyncReusePool reset];
}

@end

@implementation UIImage (Extension)

- (UIImage *)cornerRadius:(CGFloat)cornerRadius {
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
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

@implementation NSString (Extension)

- (void)preDecode:(void(^)(UIImage *))completion {
    
    CGImageRef cgImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self]]].CGImage;
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(cgImage) & kCGBitmapAlphaInfoMask;
    
    BOOL hasAlpha = NO;
    if (alphaInfo == kCGImageAlphaPremultipliedLast ||
        alphaInfo == kCGImageAlphaPremultipliedFirst ||
        alphaInfo == kCGImageAlphaLast ||
        alphaInfo == kCGImageAlphaFirst) {
        hasAlpha = YES;
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
    bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;
    
    size_t width = CGImageGetWidth(cgImage);
    size_t height = CGImageGetHeight(cgImage);
    
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, bitmapInfo);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgImage);
    cgImage = CGBitmapContextCreateImage(context);
    UIImage * image = [[UIImage imageWithCGImage:cgImage] cornerRadius:width * 0.5];
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CGImageRelease(cgImage);
    completion(image);
}

@end
