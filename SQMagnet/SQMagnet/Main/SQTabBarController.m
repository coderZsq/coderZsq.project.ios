//
//  SQTabBarController.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/12.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTabBarController.h"
#import "SQTabbarControllerAnimatedTransitioning.h"
#import "UIColor+SQExtension.h"

@interface SQTabBarController () <UITabBarControllerDelegate>

@property (nonatomic, assign) NSUInteger lastSelectIndex;

@end

@implementation SQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self hookApplicationWillEnterForeground];
}

- (void)hookApplicationWillEnterForeground {
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return [UIColor colorWithHexString:@"#1c1c1e"];
            } else {
                return [UIColor whiteColor];
            }
        }];
    }
}

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    NSUInteger fromVCIndex = [self.childViewControllers indexOfObject:fromVC];
    NSUInteger toVCIndex = [self.childViewControllers indexOfObject:toVC];
    SQTabbarControllerAnimatedTransitioning *animatedTransitioning = [SQTabbarControllerAnimatedTransitioning new];
    animatedTransitioning.fromVCIndex = fromVCIndex;
    animatedTransitioning.toVCIndex = toVCIndex;
    return animatedTransitioning;
}

@end
