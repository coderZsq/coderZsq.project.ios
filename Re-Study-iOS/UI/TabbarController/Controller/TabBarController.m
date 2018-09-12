//
//  TabBarController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "TabBarController.h"
#import "TableViewController3.h"
#import "NavigationViewController2.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"TabBar Controller";
    [self addChildViewController:[[UIStoryboard storyboardWithName:@"NavigationController" bundle:nil]instantiateInitialViewController]];
    [self addChildViewController:[[UIStoryboard storyboardWithName:@"TableViewController3" bundle:nil]instantiateInitialViewController]];

//    self.hidesBottomBarWhenPushed = YES;
    NSLog(@"%@", self.presentationController);
    NSLog(@"%@", self.childViewControllers);
    
    self.selectedIndex = 0;
    self.tabBar.tintColor = [UIColor darkGrayColor];
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tabBarItem.title = @"Castie!";
        obj.tabBarItem.image = [UIImage imageNamed:@[@"tab_qworld_nor",@"tab_me_nor"][idx]];
        obj.tabBarItem.selectedImage = [UIImage imageNamed:@[@"tab_qworld_nor",@"tab_me_nor"][idx]];
        obj.tabBarItem.badgeValue = @"666";
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
