//
//  UIBarButtonItem+Item.m
//  Network
//
//  Created by 朱双泉 on 2018/10/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+ (instancetype)itemWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage target:(id)target action:(SEL)action {
    UIButton * button = [UIButton new];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView * view = [[UIView alloc]initWithFrame:button.bounds];
    [view addSubview:button];
    return [[UIBarButtonItem alloc]initWithCustomView:view];
}

+ (instancetype)itemWithImage:(UIImage *)image selectImage:(UIImage *)highlightImage target:(nullable id)target action:(nullable SEL)action {
    UIButton * button = [UIButton new];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateSelected];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView * view = [[UIView alloc]initWithFrame:button.bounds];
    [view addSubview:button];
    return [[UIBarButtonItem alloc]initWithCustomView:view];
}

@end
