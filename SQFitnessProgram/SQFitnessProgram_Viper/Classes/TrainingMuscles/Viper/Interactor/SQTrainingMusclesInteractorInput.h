//
//  SQTrainingMusclesInteractorInput.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperInteractor.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingMusclesInteractorInput <SQViperInteractor>

- (void)loadDataSource;

- (NSArray *)fetchDataSource;

@end

NS_ASSUME_NONNULL_END
