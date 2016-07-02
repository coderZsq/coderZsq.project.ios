//
//  SQViewControllerManager.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQViewControllerManager.h"

@implementation SQViewControllerManager

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    static SQViewControllerManager * manager =nil;
    dispatch_once(&onceToken, ^{
        manager = [SQViewControllerManager new];
    });
    return manager;
}

+ (SQViewControllerManager *)shareInstance {
    return [[self alloc]init];
}

- (UIViewController *)currentViewController {
    return _currentViewController;
}

@end
