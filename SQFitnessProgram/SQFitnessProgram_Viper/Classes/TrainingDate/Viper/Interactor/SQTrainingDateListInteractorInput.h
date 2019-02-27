//
//  SQTrainingDateListInteractorInput.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperInteractor.h"
#import "SQTrainingCapacityMuscleType.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingDateListInteractorInput <SQViperInteractor>

- (void)loadDataSourceWithType:(SQTrainingCapacityMuscleType)type;

- (void)storeDataSourceWithType:(SQTrainingCapacityMuscleType)type
                     dataSource:(NSArray *)dataSource
                     completion:(void(^)(void))completion;

- (NSArray *)fetchDataSource;

@end

NS_ASSUME_NONNULL_END
