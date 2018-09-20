//
//  DemoController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "DemoController.h"
#import "SQSecondaryViewController.h"
#import "SQHomeViewController.h"
#import "SQDiscoveryViewController.h"
#import "SQMessageViewController.h"
#import "SQSettingViewController.h"

@interface DemoController () <SQSecondaryViewControllerDelegate>

@end

@implementation DemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController * mainViewController = [UIViewController new];
    NSArray * childClassArrayI = @[@"SQHomeViewController",
                                   @"SQDiscoveryViewController",
                                   @"SQMessageViewController",
                                   @"SQSettingViewController"];
    for (NSString * classString in childClassArrayI) {
        UIViewController * vc = [NSClassFromString(classString) new];
        [mainViewController addChildViewController:vc];
    }
    UIViewController * vc = [mainViewController.childViewControllers firstObject];
    [mainViewController.view addSubview:vc.view];
    self.mainViewController = mainViewController;
    
    SQSecondaryViewController * secondaryViewController = [[UIStoryboard storyboardWithName:@"SQSecondaryViewController" bundle:nil] instantiateInitialViewController];
    secondaryViewController.delegate = self;
    self.secondaryViewController = secondaryViewController;
}

- (void)secondaryViewController:(SQSecondaryViewController *)secondaryViewController currentButtonIndex:(NSInteger)currentButtonIndex preButtonIndex:(NSInteger)preButtonIndex {
    UIViewController * preVc = self.mainViewController.childViewControllers[preButtonIndex];
    [preVc.view removeFromSuperview];
    UIViewController * curVc = self.mainViewController.childViewControllers[currentButtonIndex];
    [self.mainViewController.view addSubview:curVc.view];
    [self unPan];
}

@end
