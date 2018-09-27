//
//  AppDelegate.m
//  Network
//
//  Created by 朱双泉 on 2018/9/26.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "AppDelegate.h"
#import <SDWebImageManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];
//    [[SDWebImageManager sharedManager].imageCache clearDiskOnCompletion:nil];
}

@end
