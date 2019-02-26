//
//  SQTrainingDateListProtocol.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperView.h"
#import "SQTrainingCapacityMuscleType.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingDateListViewProtocol <NSObject, SQViperView>

@property (nonatomic, assign) SQTrainingCapacityMuscleType type;

- (void)setupUI;

@end

NS_ASSUME_NONNULL_END
