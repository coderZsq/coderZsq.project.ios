//
//  SQRouter+SQTrainingCapacity.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQRouter+SQTrainingCapacity.h"
#import "SQTrainingCapacityBuilder.h"

@implementation SQRouter (SQTrainingCapacity)

+ (UIViewController *)viewForTrainingCapacityWithTitle:(NSString *)title type:(SQTrainingCapacityMuscleType)type {
    return [SQTrainingCapacityBuilder viewControllerForTrainingCapacityWithTitle:title type:type router:[self new]];
}

@end
