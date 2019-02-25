//
//  SQViperView.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SQViperViewEventHandler;

@protocol SQViperView <NSObject>

- (nullable UIViewController *)routeSource;

@property (nonatomic, readonly, strong) id<SQViperViewEventHandler> eventHandler;

@optional
@property (nonatomic, readonly, strong) id viewDataSource;

@end

NS_ASSUME_NONNULL_END
