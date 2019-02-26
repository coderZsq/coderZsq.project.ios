//
//  SQTrainingMusclesInteractor.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingMusclesInteractor.h"
#import "SQTrainingMusclesDataService.h"

@interface SQTrainingMusclesInteractor ()<SQViperInteractor>

@property (nonatomic, strong) id<SQTrainingMusclesDataService> trainingMusclesDataService;
@property (nonatomic, strong) NSArray *data;

@end

@implementation SQTrainingMusclesInteractor

- (instancetype)initWithTrainingMusclesDataService:(id<SQTrainingMusclesDataService>)service {
    if (self = [super init]) {
        _trainingMusclesDataService = service;
    }
    return self;
}

- (void)loadDataSource {
    [self.trainingMusclesDataService fetchDataSourceWithCompletion:^(NSArray * _Nonnull dataSource) {
        self.data = dataSource;
    }];
}

- (NSArray *)fetchDataSource {
    return self.data.copy;
}

@end
