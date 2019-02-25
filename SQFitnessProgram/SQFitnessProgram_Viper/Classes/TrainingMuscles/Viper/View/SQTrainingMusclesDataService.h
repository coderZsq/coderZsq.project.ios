//
//  SQTrainingMusclesDataService.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingMusclesDataService <NSObject>

@property (nonatomic, readonly, strong) NSArray *dataSource;

- (void)fetchDataSourceWithCompletion:(void(^)(NSArray *dataSource))completion;

@end

NS_ASSUME_NONNULL_END
