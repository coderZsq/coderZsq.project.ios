//
//  ProjectViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ProjectViewController.h"
#import "Main/Controller/SQTabBarController.h"

@interface ProjectViewController ()
@property (nonatomic, strong) UIViewController * rootViewController;
@end

@implementation ProjectViewController

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    
    self.rootViewController = [[UIStoryboard storyboardWithName:@"SQAdViewController" bundle:nil]instantiateInitialViewController];
}

- (void)setRootViewController:(UIViewController *)rootViewController {
    _rootViewController = rootViewController;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj performSelector:@selector(removeFromSuperview)];
    }];
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj performSelector:@selector(removeFromParentViewController)];
    }];
    [self.view addSubview:rootViewController.view];
    [self addChildViewController:rootViewController];
}

@end
