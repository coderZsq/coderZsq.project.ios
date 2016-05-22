//
//  SQTabBar.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQTabBar.h"
#import "SQTabBarButton.h"

@interface SQTabBar ()

@property (nonatomic,weak  ) SQTabBarButton * selectedButton;
@property (nonatomic,strong) NSMutableArray * tabBarButtonArr;
@property (nonatomic,strong) UIButton       * centerButton;

@end

@implementation SQTabBar

- (NSMutableArray *)tabBarButtonArr {
    
    if (!_tabBarButtonArr) {
        _tabBarButtonArr = @[].mutableCopy;
    }
    return _tabBarButtonArr;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    SQTabBarButton * button = [SQTabBarButton new];
    button.item = item;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
    [self.tabBarButtonArr addObject:button];
    if (self.tabBarButtonArr.count == 1) [self buttonClick:button];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / self.tabBarButtonArr.count;
    CGFloat buttonH = self.frame.size.height;
    for (int i = 0; i < self.tabBarButtonArr.count; i++) {
        SQTabBarButton *button = self.tabBarButtonArr[i]; button.tag = i;
        CGFloat buttonX = i * buttonW; if (i == 2 && !self.centerButton.hidden) continue;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
    self.centerButton.center = self.center;
    self.centerButton.bounds = (CGRect){CGPointZero,{buttonW,self.centerButton.currentImage.size.height}};
}

- (void)buttonClick:(SQTabBarButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItemFrom:to:)]) {
        [self.delegate tabBar:self didSelectItemFrom:self.selectedButton.tag to:sender.tag];
    }
    self.selectedButton.selected = NO; sender.selected = YES; self.selectedButton = sender;
}

- (UIButton *)centerButton {
    
    if (!_centerButton) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_centerButton addTarget:self action:@selector(centerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_centerButton setHidden:YES];
        [self addSubview:_centerButton];
    }
    return _centerButton;
}

- (void)centerButtonClick:(UIButton *)sender {
    //center button click events in here
}

@end
