//
//  SQTrainingCapacityCellPresenter.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2019/1/2.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingCapacityCellPresenter.h"
#import "SQTrainingCapacityCell.h"
#import "SQTrainingCapacityModel.h"
#import "SQTrainingCapacityNotification.h"

@interface SQTrainingCapacityCellPresenter ()
@property (nonatomic, strong) SQTrainingCapacityCell * cell;
@end

@implementation SQTrainingCapacityCellPresenter

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bindToModel) name:SQTrainingCapacityBindToModelNotification object:nil];
    }
    return self;
}

- (void)bindToModel {
    NSInteger capacity = 0;
    for (int i = 0; i < self.cell.rows.count; i++) {
        UIStackView * sv = self.cell.rows[i];
        SQTrainingCapacityRowModel * rm = self.model.rows[i];
        UITextField * groupstf = sv.subviews[0];
        UITextField * timestf = sv.subviews[1];
        UITextField * weighttf = sv.subviews[2];
        rm.groups = groupstf.text.integerValue;
        rm.times = timestf.text.integerValue;
        rm.weight = weighttf.text.integerValue;
        capacity += (rm.groups * rm.times * rm.weight);
    }
    self.model.capacity = capacity;
}

- (void)bindToCell:(SQTrainingCapacityCell *)cell {
    self.cell = cell;
    cell.actionsTextField.text = self.model.action;
    for (int i = 0; i < cell.rows.count; i++) {
        UIStackView * sv = cell.rows[i];
        SQTrainingCapacityRowModel * rm = self.model.rows[i];
        UITextField * groupstf = sv.subviews[0];
        UITextField * timestf = sv.subviews[1];
        UITextField * weighttf = sv.subviews[2];
        groupstf.text = [NSString stringWithFormat:@"%ld", rm.groups];
        timestf.text = [NSString stringWithFormat:@"%ld", rm.times];
        weighttf.text = [NSString stringWithFormat:@"%ld", rm.weight];
    }
    cell.capacityTextField.text = [NSString stringWithFormat:@"%ld", self.model.capacity];
}

@end
