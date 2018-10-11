//
//  ProjectViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ProjectViewController.h"
#import "Essence/Controller/SQEssenceViewController.h"
#import "New/Controller/SQNewViewController.h"
#import "Publish/Controller/SQPublishViewController.h"
#import "FriendTrends/Controller/SQFriendTrendsViewController.h"
#import "Me/Controller/SQMeViewController.h"
#import "Other/Category/UIImage+Render.h"

@interface ProjectViewController ()
@property (nonatomic, weak) UIButton * publishButton;
@end

@implementation ProjectViewController

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

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    
    self.publishButton.center = CGPointMake(self.tabBar.bounds.size.width * .5, self.tabBar.bounds.size.height *.5);
    
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
          }else {
              UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[obj new]];
              nav.tabBarItem.title = [[[NSStringFromClass(obj) componentsSeparatedByString:@"ViewController"]firstObject] substringFromIndex:2];
              nav.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"tabBar_%@%@_icon", [[nav.tabBarItem.title substringToIndex:1] lowercaseString], [nav.tabBarItem.title substringFromIndex:1]]] originalRender];
              nav.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"tabBar_%@%@_click_icon", [[nav.tabBarItem.title substringToIndex:1] lowercaseString], [nav.tabBarItem.title substringFromIndex:1]]] originalRender];
              [self addChildViewController:nav];
          }
      }];
}

@end
