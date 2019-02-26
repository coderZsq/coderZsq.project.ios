//
//  SQTrainingDateListInteractor.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingDateListInteractorInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingDateListDataService;

@interface SQTrainingDateListInteractor : NSObject<SQTrainingDateListInteractorInput>

@property (nonatomic, weak) id dataSource;
@property (nonatomic, weak) id eventHandler;

- (instancetype)initWithTrainingDateListDataService:(id<SQTrainingDateListDataService>)service NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
