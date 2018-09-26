//
//  UIViewController+Navigation.m
//  UI
//
//  Created by 朱双泉 on 2018/9/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "UIViewController+Navigation.h"
#import <objc/runtime.h>
#import <Masonry.h>

@implementation UIViewController (Navigation)

- (UIView *)navigationView {
    return objc_getAssociatedObject(self, @selector(navigationView));
}

- (void)setNavigationView:(UIView *)navigationView {
    objc_setAssociatedObject(self, @selector(navigationView), navigationView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)dividingView {
    return objc_getAssociatedObject(self, @selector(dividingView));
}

- (void)setDividingView:(UIView *)dividingView {
    objc_setAssociatedObject(self, @selector(dividingView), dividingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)defaultNavigationSetting {
    UIView * navigationView = [UIView new];
    navigationView.backgroundColor = [UIColor whiteColor];
    UIView * dividingView = [UIView new];
    dividingView.backgroundColor = [UIColor lightGrayColor];
    dividingView.alpha = .3;
    [navigationView addSubview:dividingView];
    [self.view addSubview:navigationView];
    [self setNavigationView:navigationView];
    [self setDividingView:dividingView];
}

- (void)defaultNavigationLayout {
    [[self navigationView] mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height);
    }];
    [[self dividingView] mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.navigationView);
        make.height.mas_equalTo(1);
    }];
}
@end
