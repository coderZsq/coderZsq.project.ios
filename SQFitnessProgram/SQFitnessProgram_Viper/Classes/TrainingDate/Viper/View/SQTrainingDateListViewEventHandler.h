//
//  SQTrainingDateListViewEventHandler.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperViewEventHandler.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingDateListViewEventHandler <SQViperViewEventHandler>

- (void)didTouchNavigationBarAddButton;

- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
