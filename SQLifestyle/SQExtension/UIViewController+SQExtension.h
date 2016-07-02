//
//  UIViewController+SQExtension.h
//
//  Created by Doubles_Z on 16-6-25.
//  Copyright (c) 2016年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SQExtension)

- (void)navigationBarGradualChangeWithScrollView:(UIScrollView *)scrollView titleView:(UIView *)titleView movableView:(UIView *)movableView offset:(CGFloat)offset color:(UIColor *)color;

- (void)setNavigationBarColor:(UIColor *)color alpha:(CGFloat)alpha;

@end
