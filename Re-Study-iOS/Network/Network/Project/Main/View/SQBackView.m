//
//  SQBackView.m
//  Network
//
//  Created by 朱双泉 on 2018/10/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQBackView.h"

@implementation SQBackView

+ (instancetype)backViewWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage target:(nullable id)target action:(nullable SEL)action title:(NSString *)title {
    UIButton * backButton = [UIButton new];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:highlightImage forState:UIControlStateHighlighted];
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backButton sizeToFit];
    //    backButton.x -= 12;
    SQBackView * view = [[self alloc]initWithFrame:backButton.bounds];
    [view addSubview:backButton];
    return view;
}

@end
