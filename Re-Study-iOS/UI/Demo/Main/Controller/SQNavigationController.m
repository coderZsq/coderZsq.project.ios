//
//  SQNavigationController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQNavigationController.h"
#import "UIImage+SQImage.h"

@interface SQNavigationController ()

@end

@implementation SQNavigationController

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        UINavigationBar * bar = [UINavigationBar appearance];
        UINavigationBar * bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
        UIImage * image = [UIImage imageNamed:@"navBg"];
        [bar setBackgroundImage:image forBarMetrics:(UIBarMetricsDefault)];
        NSDictionary * attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                      NSFontAttributeName : [UIFont boldSystemFontOfSize:20.]};
        [bar setTitleTextAttributes:attributes];
        UIImageView * imageView = [UIImageView new];
        imageView.frame = CGRectMake(0, -[[UIApplication sharedApplication] statusBarFrame].size.height, [UIScreen mainScreen].bounds.size.width, [[UIApplication sharedApplication] statusBarFrame].size.height);
        imageView.image = image;
        [bar addSubview:imageView];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
#if 0
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBg"] forBarMetrics:(UIBarMetricsDefault)];
    NSDictionary * attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                  NSFontAttributeName : [UIFont boldSystemFontOfSize:20.]};
    [self.navigationBar setTitleTextAttributes:attributes];
#endif
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
     viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageOriginalWithNamed:@"menuIcon"] style:0 target:self action:@selector(menuBarButtonClick:)];
    [super pushViewController:viewController animated:animated];
}

- (void)menuBarButtonClick:(UIBarButtonItem *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pan" object:nil];
}

@end
