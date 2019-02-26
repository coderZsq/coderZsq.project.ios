//
//  SQTrainingDateListInteractor.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingDateListInteractor.h"
#import "SQTrainingDateListDataService.h"

@interface SQTrainingDateListInteractor ()

@property (nonatomic, strong) id<SQTrainingDateListDataService> trainingDateListDataService;

@end

@implementation SQTrainingDateListInteractor

- (instancetype)initWithTrainingDateListDataService:(id<SQTrainingDateListDataService>)service {
    if (self = [super init]) {
        _trainingDateListDataService = service;
    }
    return self;
}

- (NSArray *)fetchDataSource {
    return self.trainingDateListDataService.dataSource;
}

- (void)loadDataSourceWithType:(SQTrainingCapacityMuscleType)type {
    [self.trainingDateListDataService fetchDataSourceWithType:type completion:^(NSArray * _Nonnull dataSource) {
        
    }];
}

- (void)storeDataSourceWithType:(SQTrainingCapacityMuscleType)type dataSource:(NSArray *)dataSource completion:(void (^)(void))completion {
    [self.trainingDateListDataService storeDataSourceWithType:type dataSource:dataSource completion:^{
        if (completion) {
            completion();
        }
    }];
}

@end
