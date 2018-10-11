//
//  UIImage+Render.m
//  Network
//
//  Created by 朱双泉 on 2018/10/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "UIImage+Render.h"

@implementation UIImage (Render)

- (instancetype)originalRender {
    return [self imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
}

@end
