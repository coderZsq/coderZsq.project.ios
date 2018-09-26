//
//  UIImage+Resizing.m
//  UI
//
//  Created by 朱双泉 on 2018/9/6.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "UIImage+Resizing.h"

@implementation UIImage (Resizing)

+ (instancetype)resizingImageWithName:(NSString *)name {
    UIImage * image = [UIImage imageNamed:name];
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(height * .5, width * .5, height * .5, width * .5) resizingMode:UIImageResizingModeTile];
    return image;
}

@end
