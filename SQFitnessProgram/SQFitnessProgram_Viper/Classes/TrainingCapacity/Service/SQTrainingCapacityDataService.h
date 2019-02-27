//
//  SQTrainingCapacityDataService.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/27.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQTrainingCapacityMuscleType.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingCapacityDataService <NSObject>

@property (nonatomic, readonly, copy) NSString *totalCapacity;

@property (nonatomic, readonly, strong) NSArray *dataSource;

- (void)fetchDataSourceWithTitle:(NSString *)title type:(SQTrainingCapacityMuscleType)type completion:(void(^)(NSArray *dataSource))completion;

- (void)storeDataSourceWithTitle:(NSString *)title type:(SQTrainingCapacityMuscleType)type dataSource:(nonnull NSArray *)dataSource completion:(nonnull void (^)(void))completion;

- (void)addTrainingAction;

@end

NS_ASSUME_NONNULL_END
