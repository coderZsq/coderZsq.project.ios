//
//  ReusePool.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ReusePool.h"

@interface ReusePool ()
@property (nonatomic, strong) NSMutableSet * waitUsedQueue;
@property (nonatomic, strong) NSMutableSet * usingQueue;
@end

@implementation ReusePool

- (instancetype)init
{
    self = [super init];
    if (self) {
        _waitUsedQueue = [NSMutableSet set];
        _usingQueue = [NSMutableSet set];
    }
    return self;
}

- (UIView *)dequeueReusableView {
    
    UIView * view = [_waitUsedQueue anyObject];
    if (view == nil) {
        return nil;
    } else {
        [_waitUsedQueue removeObject:view];
        [_usingQueue addObject:view];
        return view;
    }
}

- (void)addUsingView:(UIView *)view {
    if (view == nil) {
        return;
    }
    [_usingQueue addObject:view];
}

- (void)reset {
    UIView * view = nil;
    while ((view = [_usingQueue anyObject])) {
        [_usingQueue removeObject:view];
        [_waitUsedQueue addObject:view];
    }
}

@end
