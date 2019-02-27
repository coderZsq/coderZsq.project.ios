//
//  SQTrainingCapacityInteractor.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingCapacityInteractor.h"
#import "SQTrainingCapacityDataService.h"

@interface SQTrainingCapacityInteractor ()

@property (nonatomic, strong) id<SQTrainingCapacityDataService> trainingCapacityDataService;

@end

@implementation SQTrainingCapacityInteractor

- (instancetype)initWithTrainingCapacityDataService:(id<SQTrainingCapacityDataService>)service {
    if (self = [super init]) {
        _trainingCapacityDataService = service;
    }
    return self;
}

- (NSArray *)fetchDataSource {
    return self.trainingCapacityDataService.dataSource;
}

- (NSString *)totalCapacity {
    return self.trainingCapacityDataService.totalCapacity;
}

- (void)loadDataSourceWithTitle:(NSString *)title type:(SQTrainingCapacityMuscleType)type {
    [self.trainingCapacityDataService fetchDataSourceWithTitle:title type:type completion:^(NSArray * _Nonnull dataSource) {
        
    }];
}

- (void)storeDataSourceWithTitle:(NSString *)title type:(SQTrainingCapacityMuscleType)type dataSource:(NSArray *)dataSource {
    [self.trainingCapacityDataService storeDataSourceWithTitle:title type:type dataSource:dataSource completion:^{
        
    }];
}

- (void)addTrainingAction {
    [self.trainingCapacityDataService addTrainingAction];
}

@end
