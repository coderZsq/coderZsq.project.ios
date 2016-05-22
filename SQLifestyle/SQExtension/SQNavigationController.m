//
//  SQNavigationController.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQNavigationController.h"

@interface SQNavigationController ()

@end

@implementation SQNavigationController

+ (void)initialize
{
    UIColor * themeColor = [UIColor blackColor];
    UIFont  * themeFont  = [UIFont systemFontOfSize:0.1f];
    UINavigationBar * navigationBar = [UINavigationBar appearance];
    navigationBar.tintColor = themeColor;
//    [navigationBar setBackgroundImage:[UIImage imageNamed:<#name#>] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary * navigationBarAttributes = @{}.mutableCopy;
    navigationBarAttributes[NSForegroundColorAttributeName] = themeColor;
//    navigationBarAttributes[NSFontAttributeName]            = <#font#>;
    [navigationBar setTitleTextAttributes:navigationBarAttributes];
    
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    NSMutableDictionary * itemAttributes = @{}.mutableCopy;
    itemAttributes[NSForegroundColorAttributeName] = themeColor;
    itemAttributes[NSFontAttributeName]            = themeFont;
    [item setTitleTextAttributes:itemAttributes forState:0];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end
