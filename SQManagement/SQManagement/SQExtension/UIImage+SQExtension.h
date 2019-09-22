//
//  UIImage+SQExtension.h
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/12.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SQExtension)

+ (UIImage *)imageResizableNamed:(NSString *)name;

+ (UIImage *)imageWatermarkNamed:(NSString *)watermarkName named:(NSString *)name scale:(CGFloat)scale;

+ (UIImage *)imageRoundNamed:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)imageCaptureWithView:(UIView *)view;

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIColor *)pixelColorAtLocation:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
