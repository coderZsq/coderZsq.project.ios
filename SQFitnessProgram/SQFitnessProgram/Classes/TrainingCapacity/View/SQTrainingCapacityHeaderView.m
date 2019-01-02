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
    return [[NSBundle bundleForClass:self]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

@end
