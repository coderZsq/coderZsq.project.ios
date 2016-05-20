//
//  SQScaleTableHeaderView.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//


#import "SQScaleTableHeaderView.h"

@implementation SQScaleTableHeaderView

static CGFloat const factor = 0.6;

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(0, 0, 0, [UIScreen mainScreen].bounds.size.width * factor)];
        [self initializeSubviews];
    }
    return self;
}

- (void)initializeSubviews {
    // costom view in here
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

@end
