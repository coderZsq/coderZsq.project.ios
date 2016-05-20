//
//  SQCountDown_Local.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQCountDown_Local.h"
#import "NSString+SQExtension.h"

@interface SQCountDown_Local ()

@property (nonatomic,strong) NSTimer * timer;
@property (nonatomic,strong) UILabel * label;

@end

@implementation SQCountDown_Local

- (instancetype)initWithLabel:(UILabel *)label {
    
    self = [super init];
    if (self) {
        [self setupTimer];
        [self setLabel:label];
    }
    return self;
}

+ (instancetype)countDownWithLabel:(UILabel *)label {
    return [[self alloc]initWithLabel:label];
}

- (void)setupTimer {
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (NSTimer *)timer {
    
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(beginCountDown) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)beginCountDown {
    
    if (self.second <= 0) {
        [self.timer invalidate];
        return;
    }
    self.label.text = [NSString stringWithCountDownTime:self.second--];
}

@end
