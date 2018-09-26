//
//  UIImage+CircleBorder.m
//  UI
//
//  Created by 朱双泉 on 2018/9/14.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "UIImage+CircleBorder.h"

@implementation UIImage (CircleBorder)

- (instancetype)imageWithBorderWidth:(CGFloat)borderWidth color:(UIColor *)color {
    CGSize size = CGSizeMake(self.size.width + 2 * borderWidth, self.size.height + 2 * borderWidth);
    UIGraphicsBeginImageContext(size);
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [color set];
    [path fill];
    [[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)] addClip];
    [self drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    UIImage * getImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return getImage;
}

@end
