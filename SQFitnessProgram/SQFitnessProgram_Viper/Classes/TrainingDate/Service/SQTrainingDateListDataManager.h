//
//  SQTrainingDateListDataManager.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQTrainingDateListDataService.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQTrainingDateListDataManager : NSObject<SQTrainingDateListDataService>

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
