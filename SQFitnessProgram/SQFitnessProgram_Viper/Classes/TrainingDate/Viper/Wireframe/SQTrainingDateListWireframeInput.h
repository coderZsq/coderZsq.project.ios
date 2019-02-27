//
//  SQTrainingDateListWireframeInput.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQViperWireframePrivate.h"
#import "SQTrainingCapacityMuscleType.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingDateListWireframeInput <SQViperWireframePrivate>

- (void)pushTrainingCapacityWithTitle:(NSString *)title type:(SQTrainingCapacityMuscleType)type;

@end

NS_ASSUME_NONNULL_END
