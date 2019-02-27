//
//  SQTrainingCapacityDataManager.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/27.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQTrainingCapacityDataService.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQTrainingCapacityDataManager : NSObject<SQTrainingCapacityDataService>

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
