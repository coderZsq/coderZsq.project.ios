//
//  SQTabBarController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTabBarController.h"
#import "SQNavigationController.h"

@interface SQTabBarController ()

@end

@implementation SQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar.hidden = YES;
    NSArray * childClassArrayI = @[@"SQHomeViewController",
                                   @"SQDiscoveryViewController",
                                   @"SQMessageViewController",
                                   @"SQSettingViewController"];
    for (NSString * classString in childClassArrayI) {
        UIViewController * vc = [NSClassFromString(classString) new];
        SQNavigationController * nav = [[SQNavigationController alloc]initWithRootViewController:vc];
        [self addChildViewController:nav];
    }
}

@end
