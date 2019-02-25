//
//  SQTrainingMusclesPresenter.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperPresenter.h"
#import "SQTrainingMusclesViewEventHandler.h"
#import "SQTrainingMusclesDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQTrainingMusclesPresenter : NSObject<SQViperPresenter, SQTrainingMusclesViewEventHandler, SQTrainingMusclesDataSource>

@end

NS_ASSUME_NONNULL_END
