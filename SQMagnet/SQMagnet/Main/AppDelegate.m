//
//  AppDelegate.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "AppDelegate.h"
#import "NSObject+SQExtension.h"
#import "UIColor+SQExtension.h"
#import <objc/runtime.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)writeInitQuerys {
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *listArr = @[@"SQChartList", @"SQTop250List", @"SQMovie最新List", @"SQMovie冷门佳片List", @"SQMovie华语List", @"SQMovie日本List", @"SQMovie欧美List", @"SQMovie热门List", @"SQMovie韩国List", @"SQMovie高分List", @"SQTv国产剧List", @"SQTv日剧List", @"SQTv日本动画List", @"SQTv热门List", @"SQTv纪录片List", @"SQTv综艺List", @"SQTv美剧List", @"SQTv韩剧List"];
    for (NSUInteger i = 0; i < listArr.count; i++) {
        [[NSArray arrayWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:listArr[i] ofType:@"plist"]] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arr addObject:obj[@"title"]];
        }];
    }
    NSMutableString *string = @"[".mutableCopy;
    [[[NSMutableSet setWithArray:arr] allObjects] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendFormat:@"\"%@\", ", obj];
    }];
    [string replaceCharactersInRange:NSMakeRange(string.length -2, 1) withString:@"]"];
    [@[string] writeToFile:@"/System/Volumes/Data/Users/zhushuangquan/Native Drive/GitHub/coderZsq.practice.data/magnet/data/SQQuerysString.plist" atomically:YES];
}

- (void)updateQuerys {
    NSMutableArray *arr = @[].mutableCopy;
    NSMutableArray *arr2 = @[].mutableCopy;
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"SQHomeData" ofType:@"plist"]]];
    [dict addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"SQMovieData" ofType:@"plist"]]];
    [dict addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"SQTVData" ofType:@"plist"]]];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSArray  *obj, BOOL * _Nonnull stop) {
        [arr addObjectsFromArray:obj];
    }];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arr2 addObject:obj[@"title"]];
    }];
    NSMutableString *string = @"[".mutableCopy;
    [[[NSMutableSet setWithArray:arr2] allObjects] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendFormat:@"\"%@\", ", obj];
    }];
    [string replaceCharactersInRange:NSMakeRange(string.length -2, 1) withString:@"]"];
    [@[string] writeToFile:@"/System/Volumes/Data/Users/zhushuangquan/Native Drive/GitHub/coderZsq.practice.data/magnet/data/SQQuerysString.plist" atomically:YES];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIView appearance].tintColor = [UIColor colorWithHexString:@"#EC566D"];
//    [self writeInitQuerys];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    UIViewController *currentVC = [self getCurrentViewController];
    if([currentVC isKindOfClass:NSClassFromString(@"SQListViewController")]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [currentVC performSelector:@selector(hookApplicationWillEnterForeground) withObject:nil];
#pragma clang diagnostic pop
    }
    UITabBarController *rootVC = (UITabBarController *)[self getRootViewController];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
   [rootVC performSelector:@selector(hookApplicationWillEnterForeground) withObject:nil];
#pragma clang diagnostic pop
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
