//
//  AsyncDrawLayer.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/6.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "AsyncDrawLayer.h"

@implementation AsyncDrawLayer

- (void)increaseCount {
    _drawsCount++;
}

- (void)setNeedsDisplay {
    [self increaseCount];
    [super setNeedsDisplay];
}

- (void)setNeedsDisplayInRect:(CGRect)r {
    [self increaseCount];
    [super setNeedsDisplayInRect:r];
}

@end
