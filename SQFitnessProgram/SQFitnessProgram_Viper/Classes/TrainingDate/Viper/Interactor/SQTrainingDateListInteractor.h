//
//  SQTrainingDateListInteractor.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingDateListInteractorInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQTrainingDateListInteractor : NSObject<SQTrainingDateListInteractorInput>

@property (nonatomic, weak) id dataSource;
@property (nonatomic, weak) id eventHandler;

@end

NS_ASSUME_NONNULL_END
