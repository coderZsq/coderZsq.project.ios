//
//  SQTrainingMusclesInteractor.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingMusclesInteractorInput.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingMusclesDataService;

@interface SQTrainingMusclesInteractor : NSObject<SQTrainingMusclesInteractorInput>

@property (nonatomic, weak) id dataSource;
@property (nonatomic, weak) id eventHandler;

- (instancetype)initWithTrainingMusclesDataService:(id<SQTrainingMusclesDataService>)service NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
