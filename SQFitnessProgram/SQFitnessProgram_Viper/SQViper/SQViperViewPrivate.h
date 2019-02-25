//
//  SQViperViewPrivate.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQViperViewEventHandler;

@protocol SQViperViewPrivate <SQViperView>

- (id<SQViperViewEventHandler>)eventHandler;

- (void)setEventHandler:(id<SQViperViewEventHandler>)eventHandler;

@optional
- (id)viewDataSource;

- (void)setViewDataSource:(id)viewDataSource;

- (void)setRouteSource:(UIViewController *)routeSource;

@end

NS_ASSUME_NONNULL_END
