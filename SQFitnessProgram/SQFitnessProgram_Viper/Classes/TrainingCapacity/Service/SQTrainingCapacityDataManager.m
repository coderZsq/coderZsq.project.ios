//
//  SQTrainingCapacityDataManager.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/27.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingCapacityDataManager.h"
#import "SQTrainingCapacityDataBase.h"
#import "SQSqliteModelTool.h"

@interface SQTrainingCapacityDataManager ()

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) SQTrainingCapacityDataBase * dataBase;

@end

@implementation SQTrainingCapacityDataManager

+ (instancetype)sharedInstance {
    static SQTrainingCapacityDataManager *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [SQTrainingCapacityDataManager new];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _data = [NSMutableArray array];
        _dataBase = [SQTrainingCapacityDataBase new];
    }
    return self;
}

- (NSArray *)dataSource {
    return self.data.copy;
}

- (void)fetchDataSourceWithType:(SQTrainingCapacityMuscleType)type completion:(nonnull void (^)(NSArray * _Nonnull))completion {
    NSAssert([NSThread isMainThread], @"main thread only, otherwise use lock to make thread safety");
    
}

@end
