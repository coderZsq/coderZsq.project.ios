//
//  SQTrainingCapacityInteractorInput.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/27.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperInteractor.h"
#import "SQTrainingCapacityMuscleType.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingCapacityInteractorInput <NSObject, SQViperInteractor>

- (void)loadDataSourceWithType:(SQTrainingCapacityMuscleType)type;

@end

NS_ASSUME_NONNULL_END
