//
//  SQTrainingCapacityInteractor.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingCapacityInteractorInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingCapacityInteractorDataSource;
@protocol SQTrainingCapacityInteractorEventHandler;
@protocol SQTrainingCapacityDataService;

@interface SQTrainingCapacityInteractor : NSObject<SQTrainingCapacityInteractorInput>

@property (nonatomic, weak) id<SQTrainingCapacityInteractorDataSource> dataSource;
@property (nonatomic, weak) id<SQTrainingCapacityInteractorEventHandler> eventHandler;

- (instancetype)initWithTrainingCapacityDataService:(id<SQTrainingCapacityDataService>)service NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
