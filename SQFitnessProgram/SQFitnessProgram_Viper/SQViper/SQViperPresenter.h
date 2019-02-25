//
//  SQViperPresenter.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperViewEventHandler.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQViperView;

@protocol SQViperPresenter <SQViperViewEventHandler>

@property (nonatomic, readonly, weak) id <SQViperView> view;

@end

NS_ASSUME_NONNULL_END
