//
//  SQTrainingMusclesBuilder.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SQViperRouter;
@protocol SQViperView;
@protocol SQTrainingMusclesDataService;

@interface SQTrainingMusclesBuilder : NSObject

+ (UIViewController *)viewControllerWithTrainingMusclesDataService:(id<SQTrainingMusclesDataService>)service router:(id<SQViperRouter>)router;

+ (void)buildView:(id<SQViperView>)view trainingMusclesDataService:(id<SQTrainingMusclesDataService>)service router:(id<SQViperRouter>)router;

@end

NS_ASSUME_NONNULL_END
