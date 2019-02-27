//
//  SQTrainingCapacityViewEventHandler.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/27.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperViewEventHandler.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingCapacityViewEventHandler <SQViperViewEventHandler>

- (void)didTouchNavigationBarAddButton;

- (void)handleCommitEditingAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
