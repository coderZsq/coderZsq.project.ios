//
//  UIViewController+SQExtension.h
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/12.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SQExtension)

- (UILabel *)findNavigationBarContentViewTitleLabel;

- (void)navigationBarGradualChangeWithScrollView:(UIScrollView *)scrollView titleView:(UIView *)titleView movableView:(UIView *)movableView offset:(CGFloat)offset color:(UIColor *)color;

- (void)setNavigationBarColor:(UIColor *)color alpha:(CGFloat)alpha;

@end
