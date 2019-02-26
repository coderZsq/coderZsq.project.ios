//
//  SQTrainingDateListDataService.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQTrainingCapacityMuscleType.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingDateListDataService <NSObject>

@property (nonatomic, readonly, strong) NSArray *dataSource;

- (void)fetchDataSourceWithType:(SQTrainingCapacityMuscleType)type completion:(void(^)(NSArray *dataSource))completion;

- (void)storeDataSourceWithType:(SQTrainingCapacityMuscleType)type dataSource:(nonnull NSArray *)dataSource completion:(nonnull void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
