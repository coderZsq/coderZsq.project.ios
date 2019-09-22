//
//  UIViewController+SQExtension.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/12.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "UIViewController+SQExtension.h"
#import "UIImage+SQExtension.h"
#import "UIView+SQExtension.h"

@implementation UIViewController (SQExtension)

- (UILabel *)findNavigationBarContentViewTitleLabel {
    for (UIView * _UINavigationBarContentView in self.navigationController.navigationBar.subviews) {
        if ([_UINavigationBarContentView isKindOfClass:NSClassFromString(@"_UINavigationBarContentView")]) {
            for (UILabel *titleLabel in _UINavigationBarContentView.subviews) {
                if ([titleLabel isKindOfClass:UILabel.class] && [titleLabel.text isEqualToString:self.title]) {
                    return titleLabel;
                }
            }
        }
    }
    return nil;
}

- (void)navigationBarGradualChangeWithScrollView:(UIScrollView *)scrollView titleView:(UIView *)titleView movableView:(UIView *)movableView offset:(CGFloat)offset color:(UIColor *)color {
    
    [self viewWillLayoutSubviews];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.navigationController.navigationBar setUserInteractionEnabled:scrollView.contentOffset.y > offset ? YES : NO];
    
    float alpha = 1 - ((offset - scrollView.contentOffset.y) / offset);
    [self setNavigationBarColor:color alpha:alpha];
    titleView  .hidden = scrollView.contentOffset.y > offset ? NO : YES;
    movableView.hidden = !titleView.hidden;
}

- (void)setNavigationBarColor:(UIColor *)color alpha:(CGFloat)alpha {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[color colorWithAlphaComponent:alpha > 0.95f ? 0.95f : alpha]] forBarMetrics:UIBarMetricsDefault];
    if (self.navigationController.viewControllers.count > 1) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
        view.backgroundColor = color; [self.view addSubview:view];
    }
}

@end
