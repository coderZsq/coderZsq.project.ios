//
//  SQNavigationController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQNavigationController.h"
#import "SQNavigationBar.h"
#import "SQBackView.h"

@interface SQNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation SQNavigationController

+ (void)load {
    UINavigationBar * bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    bar.titleTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]};
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:(UIBarMetricsDefault)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.interactivePopGestureRecognizer.delegate = self;
    id target = self.interactivePopGestureRecognizer.delegate;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    [self.interactivePopGestureRecognizer setEnabled:NO];
    SQNavigationBar * bar = [[SQNavigationBar alloc]initWithFrame:self.navigationBar.frame];
    [self setValue:bar forKey:@"navigationBar"];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[SQBackView backViewWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highlightImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(backButtonClick:) title:@"Back"]];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)backButtonClick:(UIButton *)sender {
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count == 1 ? NO : YES;
}

@end
