//
//  ComponentLayout.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ComponentLayout.h"
#import "Element.h"

@implementation ComponentLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _labels = [NSMutableArray new];
        _label2 = [Element new];
        _label3 = [Element new];
        _label4 = [Element new];
    }
    return self;
}

@end
