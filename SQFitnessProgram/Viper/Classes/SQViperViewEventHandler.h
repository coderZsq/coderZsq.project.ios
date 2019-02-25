//
//  SQViperViewEventHandler.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SQViperViewEventHandler <NSObject>

@optional
- (void)handleViewReady;

- (void)handleViewRemoved;

- (void)handleViewWillAppear:(BOOL)animated;

- (void)handleViewDidAppear:(BOOL)animated;

- (void)handleViewWillDisappear:(BOOL)animated;

- (void)handleViewDidDisappear:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
