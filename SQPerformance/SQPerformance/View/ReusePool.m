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
@property (nonatomic, strong) NSLock * lock;
@end

@implementation ReusePool

- (instancetype)init
{
    self = [super init];
    if (self) {
        _waitUsedQueue = [NSMutableSet set];
        _usingQueue = [NSMutableSet set];
        _lock = [NSLock new];
    }
    return self;
}

- (NSObject *)dequeueReusableObject {
    
    NSObject * object = [_waitUsedQueue anyObject];
    if (object == nil) {
        return nil;
    } else {
        [_lock lock];
        [_waitUsedQueue removeObject:object];
        [_usingQueue addObject:object];
        [_lock unlock];
        return object;
    }
}

- (void)addUsingObject:(UIView *)object {
    if (object == nil) {
        return;
    }
    [_lock lock];
    [_usingQueue addObject:object];
    [_lock unlock];
}

- (void)reset {
    NSObject * object = nil;
    while ((object = [_usingQueue anyObject])) {
        [_lock lock];
        [_usingQueue removeObject:object];
        [_waitUsedQueue addObject:object];
        [_lock unlock];
    }
}

@end
