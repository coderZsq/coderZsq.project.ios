//
//  SQBundleVersionManager.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQBundleVersionManager.h"
#import "SQTabBarController.h"
#import "SQNewFeatureViewController.h"
#import "SQLifestyleViewController.h"
#import "SQDiscoverViewController.h"
#import "SQProfileViewController.h"

@implementation SQBundleVersionManager

+ (instancetype)manager {
    return [[self alloc]init];
}

- (void)setWindow:(UIWindow *)window {
    _window = window; [self prepareForBundleVersionKey];
}

- (void)prepareForBundleVersionKey {
    
    NSString * key = @"CFBundleVersion";
    NSUserDefaults * userDefaults   = [NSUserDefaults standardUserDefaults];
    NSString       * lastVersion    = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    NSString       * currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        self.window.rootViewController = [self getTabbarController];
    } else {
        self.window.rootViewController = [self getNewFeatureController];
        [userDefaults setObject:currentVersion forKey:key];
        [userDefaults synchronize];
    }
}

- (SQNewFeatureViewController *)getNewFeatureController {
    
    __weak typeof(self) _self = self;
    SQNewFeatureViewController * newfeature = [SQNewFeatureViewController new];
    newfeature.newfeatureImages = @[@"1",@"2",@"3",@"4"];
    newfeature.enterButtonImage = [UIImage imageWithColor:[UIColor clearColor]];
    newfeature.block = ^{
        _self.window.rootViewController = [self getTabbarController];
    };
    return newfeature;
}

- (SQTabBarController *)getTabbarController {
    
    return [SQTabBarController tabbarWithViewControllers:@[[SQLifestyleViewController new],
                                                           [SQDiscoverViewController new],
                                                           [SQProfileViewController new]]
                                                  titles:@[@"Lifestyle",
                                                           @"Discover",
                                                           @"Profile"]
                                              imageNames:@[kTabbar_lifestyle,
                                                           kTabbar_discover,
                                                           kTabbar_profile]
                                      selectedImageNames:@[kTabbar_lifestyle_select,
                                                           kTabbar_discover_select,
                                                           kTabbar_profile_select]];
}

@end
