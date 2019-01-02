//
//  SQTrainingCapacityHeaderView.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2018/12/31.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTrainingCapacityHeaderView.h"

@implementation SQTrainingCapacityHeaderView

+ (instancetype)headerView {
    UIView * view = [[NSBundle bundleForClass:self]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    view.frame = CGRectMake(0, 0, 0, 21);
    return (SQTrainingCapacityHeaderView *)view;
}

@end
