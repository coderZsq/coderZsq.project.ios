//
//  SQRouter+SQTrainingDateList.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQRouter+SQTrainingDateList.h"
#import "SQTrainingDateListBuilder.h"

@implementation SQRouter (SQTrainingDateList)

+ (UIViewController *)viewForTrainingDateListWithType:(SQTrainingCapacityMuscleType)type {
    return [SQTrainingDateListBuilder viewControllerForTrainingDateListWithType:type router:[self new]];
}

@end
