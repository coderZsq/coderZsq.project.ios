//
//  UIImage+SQExtension.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SQExtension)

+ (UIImage *)imageResizableNamed:(NSString *)name;

+ (UIImage *)imageWatermarkNamed:(NSString *)watermarkName named:(NSString *)name scale:(CGFloat)scale;

+ (UIImage *)imageRoundNamed:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (UIImage *)imageCaptureWithView:(UIView *)view;

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIColor *)pixelColorAtLocation:(CGPoint)point;

@end
