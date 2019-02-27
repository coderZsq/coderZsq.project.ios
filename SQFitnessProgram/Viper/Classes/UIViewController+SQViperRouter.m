//
//  UIViewController+SQViperRouter.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "UIViewController+SQViperRouter.h"

@implementation UIViewController (SQViperRouter)

- (BOOL)SQ_isAppRootViewController {
    NSAssert([UIApplication sharedApplication].delegate.window.rootViewController, @"Can't find rootViewController");
    return [UIApplication sharedApplication].delegate.window.rootViewController == self;
}

- (BOOL)SQ_isRemoving {
    UIViewController *destination = (UIViewController *)self;
    UIViewController *node = destination;
    while (node) {
        if (node.isMovingFromParentViewController ||
            (!node.parentViewController && !node.presentingViewController && ![node SQ_isAppRootViewController])) {
            return YES;
        } else if (node.isBeingDismissed) {
            return YES;
        } else {
            node = node.parentViewController;
            continue;
        }
        break;
    }
    return NO;
}

@end
