//
//  SQTrainingCapacityDataBase.h
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2019/1/2.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQTrainingCapacityMuscleType.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQTrainingCapacityDataBase : NSObject

@property (nonatomic, copy) NSString * key;

@property (nonatomic, copy) NSString * date;

@property (nonatomic, assign) SQTrainingCapacityMuscleType type;

@property (nonatomic, copy) NSArray * dataSource;

@end

NS_ASSUME_NONNULL_END
