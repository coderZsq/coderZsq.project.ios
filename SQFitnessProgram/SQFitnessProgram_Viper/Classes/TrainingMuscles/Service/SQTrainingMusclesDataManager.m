//
//  SQTrainingMusclesService.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingMusclesDataManager.h"

@interface SQTrainingMusclesDataManager ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation SQTrainingMusclesDataManager

+ (instancetype)sharedInstance {
    static SQTrainingMusclesDataManager *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [SQTrainingMusclesDataManager new];
    });
    return shared;
}

- (NSArray *)dataSource {
    return self.data.copy;
}

- (void)fetchDataSourceWithCompletion:(void (^)(NSArray * _Nonnull))completion {
    NSAssert([NSThread isMainThread], @"main thread only, otherwise use lock to make thread safety");
    self.data = @[@"Pectoral muscle",
                  @"Back muscle",
                  @"Leg muscle",
                  @"Shoulder muscle",
                  @"Arm muscle",
                  @"Abdominal muscle"];
    if (completion) {
        completion(self.data);
    }
}


@end
