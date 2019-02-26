//
//  SQTrainingDateListDataBase.h
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2019/1/2.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQTrainingCapacityMuscleType.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQTrainingDateListDataBase : NSObject

@property (nonatomic, assign) SQTrainingCapacityMuscleType type;
    
@property (nonatomic, strong) NSArray <NSString *> * dateList;
    
@end

NS_ASSUME_NONNULL_END
