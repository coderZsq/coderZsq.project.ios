//
//  UIBarButtonItem+SQExtension.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "UIBarButtonItem+SQExtension.h"

@implementation UIBarButtonItem (SQExtension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action {
    
    UIButton * button = [UIButton buttonWithType: UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imageName]            forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setBounds:(CGRect){CGPointZero, button.currentBackgroundImage.size}];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end
