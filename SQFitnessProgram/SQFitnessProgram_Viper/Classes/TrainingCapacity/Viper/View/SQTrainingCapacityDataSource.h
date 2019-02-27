//
//  SQTrainingCapacityDataSource.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/27.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingCapacityDataSource <NSObject>

@property (nonatomic, readonly, copy) NSString *totalCapacity;

- (NSArray *)fetchDataSourceFromDB;

@end

NS_ASSUME_NONNULL_END
