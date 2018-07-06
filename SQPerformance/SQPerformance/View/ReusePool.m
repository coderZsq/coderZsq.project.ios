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

- (NSObject *)dequeueReusableObject {
    
    NSObject * object = [_waitUsedQueue anyObject];
    if (object == nil) {
        return nil;
    } else {
        [_waitUsedQueue removeObject:object];
        [_usingQueue addObject:object];
        return object;
    }
}

- (void)addUsingObject:(UIView *)object {
    if (object == nil) {
        return;
    }
    [_usingQueue addObject:object];
}

- (void)reset {
    NSObject * object = nil;
    while ((object = [_usingQueue anyObject])) {
        [_usingQueue removeObject:object];
        [_waitUsedQueue addObject:object];
    }
}

@end
