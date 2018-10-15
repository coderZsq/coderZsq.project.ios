//
//  SQTabBarController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTabBarController.h"
#import "SQEssenceViewController.h"
#import "SQNewViewController.h"
#import "SQPublishViewController.h"
#import "SQFriendTrendsViewController.h"
#import "SQMeViewController.h"
#import "UIImage+Render.h"
#import "SQNavigationController.h"

@interface SQTabBarController ()
@property (nonatomic, weak) UIButton * publishButton;
@end

@implementation SQTabBarController

+ (void)load {
    UITabBarItem * item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [UIColor grayColor]} forState:(UIControlStateNormal)];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor]} forState:(UIControlStateSelected)];
}

- (UIButton *)publishButton {
    
    if (!_publishButton) {
        UIButton * publishButton = [UIButton new];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:(UIControlStateNormal)];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:(UIControlStateHighlighted)];
        [publishButton sizeToFit];
        [self.tabBar addSubview:publishButton];
        _publishButton = publishButton;
    }
    return _publishButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.publishButton.center = CGPointMake(self.tabBar.bounds.size.width * .5, self.tabBar.bounds.size.height * .5);
    
    [@[[SQEssenceViewController class],
       [SQNewViewController class],
       [SQPublishViewController class],
       [SQFriendTrendsViewController class],
       [SQMeViewController class]] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           if (idx == 2) {
               UIViewController * vc = [obj new];
               //              vc.tabBarItem.image = [[UIImage imageNamed:@"tabBar_publish_icon"] originalRender];
               //              vc.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabBar_publish_click_icon"] originalRender];
               //              vc.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
               vc.tabBarItem.enabled = NO;
               [self addChildViewController:vc];
           } else {
               UIViewController * vc = nil;
               UIStoryboard * sb = nil;
               @try {
                   sb = [UIStoryboard storyboardWithName:NSStringFromClass(obj) bundle:nil];
               } @catch (NSException *exception)  {
                   NSLog(@"%@", exception);
               } @finally {
                   if (sb) vc = [sb instantiateInitialViewController];
                   else vc = [obj new];
               }
               SQNavigationController * nav = [[SQNavigationController alloc]initWithRootViewController:vc];
               nav.tabBarItem.title = [[[NSStringFromClass(obj) componentsSeparatedByString:@"ViewController"]firstObject] substringFromIndex:2];
               nav.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"tabBar_%@%@_icon", [[nav.tabBarItem.title substringToIndex:1] lowercaseString], [nav.tabBarItem.title substringFromIndex:1]]] originalRender];
               nav.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"tabBar_%@%@_click_icon", [[nav.tabBarItem.title substringToIndex:1] lowercaseString], [nav.tabBarItem.title substringFromIndex:1]]] originalRender];
               [self addChildViewController:nav];
           }
       }];
}

@end
