//
//  SQRouter+SQTrainingCapacity.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQRouter.h"
#import "SQTrainingCapacityMuscleType.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQRouter (SQTrainingCapacity)

+ (UIViewController *)viewForTrainingCapacityWithTitle:(NSString *)title type:(SQTrainingCapacityMuscleType)type;

@end

NS_ASSUME_NONNULL_END
