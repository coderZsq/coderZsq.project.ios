//
//  SQTabBarController.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQTabBarController.h"
#import "SQTabBar.h"
#import "SQTabbarControllerAnimatedTransitioning.h"
#import "SQTabBarGlobal.h"

#import "SQNavigationController.h"

@interface SQTabBarController () <SQTabBarDelegate,UITabBarControllerDelegate>

@property (nonatomic,strong) SQTabBar * sqTabBar;

@end

@implementation SQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar addSubview:self.sqTabBar];
    [self.view setBackgroundColor: TABBAR_BGC];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (UIView * subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:[UIControl class]]) {
            [subView removeFromSuperview];
        }
    }
}

- (SQTabBar *)sqTabBar {
    
    if (!_sqTabBar) {
        _sqTabBar = [SQTabBar new];
        _sqTabBar.frame    = self.tabBar.bounds;
        _sqTabBar.delegate = self;
    }
    return _sqTabBar;
}

+ (instancetype)tabbarWithViewControllers:(NSArray *)viewcontrollers titles:(NSArray *)titles imageNames:(NSArray *)imageNames selectedImageNames:(NSArray *)selectedImageNames {
    
    SQTabBarController * tabbarController = [SQTabBarController new];
    for (int i = 0; i < viewcontrollers.count; i++) {
        [tabbarController setupViewController:viewcontrollers[i] title:titles[i] imageName:imageNames[i] selectedImageName:selectedImageNames[i]];
    }
    return tabbarController;
}

- (void)setupViewController:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {

    viewController.title = title;
    viewController.tabBarItem.image         = [UIImage imageNamed:imageName];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    [self addChildViewController:[[SQNavigationController alloc]initWithRootViewController:viewController]];
    [self.sqTabBar addTabBarButtonWithItem:viewController.tabBarItem];
}

- (void)tabBar:(SQTabBar *)tabBar didSelectItemFrom:(NSInteger)preIndex to:(NSInteger)selectedIndex {

                         _preIndex      = preIndex;
    self.selectedIndex = _selectedIndex = selectedIndex;
    self.delegate      = self;
}

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return [SQTabbarControllerAnimatedTransitioning new];
}

@end
