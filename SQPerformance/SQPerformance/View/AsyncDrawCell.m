//
//  AsyncDrawCell.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "AsyncDrawCell.h"
#import "AsyncDrawLayer.h"
#import "PermenantThread.h"

@interface AsyncDrawCell()
@property (nonatomic,weak) AsyncDrawLayer * drawLayer;
@property (nonatomic,strong) PermenantThread * thread;
@end

@implementation AsyncDrawCell

- (void)dealloc {
    [_thread stop];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.opaque = NO;
        self.layer.contentsScale = [[UIScreen mainScreen] scale];
        if ([self.layer isKindOfClass:[AsyncDrawLayer class]]) {
            _drawLayer = (AsyncDrawLayer *)self.layer;
        }
        _thread = [PermenantThread new];
    }
    return self;
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
        
        CGSize size = layer.bounds.size;
        BOOL contextSizeValid = size.width >= 1 && size.height >= 1;
        
        if (contextSizeValid) {
            CGFloat scaleFactor = [[UIScreen mainScreen] scale];
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGContextRef context = CGBitmapContextCreate(NULL, size.width * scaleFactor, size.height * scaleFactor, 8, size.width * 4 * scaleFactor, colorSpace, kCGImageAlphaPremultipliedFirst | kCGImageByteOrderDefault);
            CGColorSpaceRelease(colorSpace);
            CGAffineTransform normalState = CGContextGetCTM(context);
            CGContextTranslateCTM(context, 0, size.height * scaleFactor);
            CGContextScaleCTM(context, scaleFactor, -scaleFactor);
            CGContextConcatCTM(context, normalState);
            if (backgroundColor && backgroundColor != [UIColor clearColor]) {
                CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
                CGContextFillRect(context, bounds);
            }
            UIGraphicsPushContext(context);
            [self asyncDraw:YES context:context completion:^(BOOL drawing, BOOL finished) {
                if (drawing && oldCount == tempLayer.drawsCount) {
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
                if (finished) {
                    CGContextRelease(context);
                }
            }];
        }
        UIGraphicsPopContext();
    }];
}

- (void)asyncDraw:(BOOL)asynchronously context:(CGContextRef)context completion:(void(^)(BOOL, BOOL))completion {}

@end
