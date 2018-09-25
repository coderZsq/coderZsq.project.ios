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
#import "SQTabBarController.h"
#import "SQNewFeatureViewController.h"

@interface DemoController () <SQSecondaryViewControllerDelegate>
@property (nonatomic, weak) SQTabBarController * tabbarVc;
@end

@implementation DemoController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if 0
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
#endif
    SQTabBarController * tabbarVc = [SQTabBarController new];
    self.mainViewController = self.tabbarVc = tabbarVc;
    SQSecondaryViewController * secondaryViewController = [[UIStoryboard storyboardWithName:@"SQSecondaryViewController" bundle:nil] instantiateInitialViewController];
    secondaryViewController.delegate = self;
    self.secondaryViewController = secondaryViewController;
    SQNewFeatureViewController * newFeatureViewController = [SQNewFeatureViewController new];
    self.featureViewController = newFeatureViewController;
    self.ratio = .55;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pan) name:@"pan" object:nil];
}

- (void)secondaryViewController:(SQSecondaryViewController *)secondaryViewController currentButtonIndex:(NSInteger)currentButtonIndex preButtonIndex:(NSInteger)preButtonIndex {
#if 0
    UIViewController * preVc = self.mainViewController.childViewControllers[preButtonIndex];
    [preVc.view removeFromSuperview];
    UIViewController * curVc = self.mainViewController.childViewControllers[currentButtonIndex];
    [self.mainViewController.view addSubview:curVc.view];
#endif
    self.tabbarVc.selectedIndex = currentButtonIndex;
    [self unPan];
}

- (void)secondaryViewControllerDidClickedCityButton:(SQSecondaryViewController *)secondaryViewController {
    [self unPan];
}

@end
