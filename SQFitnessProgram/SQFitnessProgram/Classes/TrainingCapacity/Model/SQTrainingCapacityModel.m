//
//  SQTrainingCapacityModel.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2019/1/2.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingCapacityModel.h"

@implementation SQTrainingCapacityRowModel

@end

@implementation SQTrainingCapacityModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSMutableArray * rows = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            SQTrainingCapacityRowModel * rowModel = [SQTrainingCapacityRowModel new];
            rowModel.groups = 1;
            rowModel.times = 0;
            rowModel.weight = 0;
            [rows addObject:rowModel];
        }
        self.rows = rows;
    }
    return self;
}

@end
