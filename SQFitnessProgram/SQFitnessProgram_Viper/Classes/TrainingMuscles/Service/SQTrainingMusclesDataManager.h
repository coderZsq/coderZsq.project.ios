//
//  SQTrainingMusclesService.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQTrainingMusclesDataService.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQTrainingMusclesDataManager : NSObject<SQTrainingMusclesDataService>

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
