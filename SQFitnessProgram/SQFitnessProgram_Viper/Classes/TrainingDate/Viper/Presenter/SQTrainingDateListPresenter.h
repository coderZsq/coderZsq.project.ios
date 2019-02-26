//
//  SQTrainingDateListPresenter.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperPresenter.h"
#import "SQTrainingDateListViewEventHandler.h"
#import "SQTrainingDateListDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQTrainingDateListPresenter : NSObject<SQViperPresenter, SQTrainingDateListViewEventHandler, SQTrainingDateListDataSource>

@end

NS_ASSUME_NONNULL_END
