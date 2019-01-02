//
//  SQTrainingCapacityOperationView.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2019/1/2.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingCapacityOperationView.h"

@implementation SQTrainingCapacityOperationView

+ (instancetype)operationView {
    return [[NSBundle bundleForClass:self]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

@end
