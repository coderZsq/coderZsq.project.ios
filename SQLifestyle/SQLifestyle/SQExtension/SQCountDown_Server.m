//
//  SQCountDown_Server.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQCountDown_Server.h"

@implementation SQCountDown_Server

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self setupTimer];
    }
    return self;
}

- (void)setupTimer {
    NSTimer * timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(beginCountDown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)beginCountDown {
    self.countDownSecond--;
}

@end
