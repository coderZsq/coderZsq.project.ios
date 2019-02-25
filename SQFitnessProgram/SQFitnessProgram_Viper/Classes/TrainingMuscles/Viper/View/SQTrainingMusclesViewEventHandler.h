//
//  SQTrainingMusclesViewEventHandler.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperViewEventHandler.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingMusclesViewEventHandler <SQViperViewEventHandler>

- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
