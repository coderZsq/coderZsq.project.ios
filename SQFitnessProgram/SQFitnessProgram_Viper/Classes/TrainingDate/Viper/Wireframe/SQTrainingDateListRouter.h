//
//  SQTrainingDateListRouter.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQViperRouter.h"
#import "SQTrainingCapacityMuscleType.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingDateListRouter <SQViperRouter>

+ (UIViewController *)viewForTrainingCapacityWithTitle:(NSString *)title type:(SQTrainingCapacityMuscleType)type;

@end

NS_ASSUME_NONNULL_END
