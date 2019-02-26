//
//  UIApplication+SQViperRouter.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SQRouter;

@interface UIApplication (SQViperRouter)

- (SQRouter *)SQ_router;

@end

NS_ASSUME_NONNULL_END
