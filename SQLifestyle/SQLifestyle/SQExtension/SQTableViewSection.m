//
//  SQTableViewSection.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQTableViewSection.h"

@implementation SQTableViewSection

- (instancetype)init
{
    self = [super init];
    if (self) {
        _rows = [@[] mutableCopy];
    }
    return self;
}

@end
