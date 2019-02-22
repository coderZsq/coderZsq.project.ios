//
//  SQViperInteractor.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SQViperInteractor <NSObject>

@property (nonatomic, readonly, weak) id dataSource;
@property (nonatomic, readonly, weak) id eventHandler;

@end

NS_ASSUME_NONNULL_END
