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

- (NSArray *)fetchDataSource {
    return self.trainingDateListDataService.dataSource;
}

- (void)loadDataSource {
    [self.trainingDateListDataService fetchDataSourceWithCompletion:^(NSArray * _Nonnull dataSource) {
        
    }];
}

@end
