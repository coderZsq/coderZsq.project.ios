//
//  SQTrainingCapacityFooterView.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2018/12/31.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTrainingCapacityFooterView.h"

@implementation SQTrainingCapacityFooterView

+ (instancetype)footerView {
    return [[NSBundle bundleForClass:self]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

@end
