//
//  NSObject+SQExtension.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/13.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "NSObject+SQExtension.h"

@implementation NSObject (SQExtension)

- (UIViewController *)getRootViewController {
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

- (UIViewController *)getCurrentViewController {
    UIViewController* currentViewController = [self getRootViewController];
    BOOL flag = YES;
    while (flag) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabBarController = (UITabBarController *)currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                currentViewController = currentViewController.childViewControllers.lastObject;
                return currentViewController;
            } else {
                return currentViewController;
            }
        }
    }
    return currentViewController;
}

@end
