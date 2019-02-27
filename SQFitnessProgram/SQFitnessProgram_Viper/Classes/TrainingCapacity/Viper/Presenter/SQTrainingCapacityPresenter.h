//
//  SQTrainingCapacityPresenter.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperPresenter.h"
#import "SQTrainingCapacityViewEventHandler.h"
#import "SQTrainingCapacityDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQTrainingCapacityPresenter : NSObject<SQViperPresenter, SQTrainingCapacityViewEventHandler, SQTrainingCapacityDataSource>

@end

NS_ASSUME_NONNULL_END
