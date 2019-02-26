//
//  SQTrainingDateListDataManager.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingDateListDataManager.h"
#import "SQTrainingDateListDataBase.h"
#import "SQSqliteModelTool.h"

@interface SQTrainingDateListDataManager ()

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) SQTrainingDateListDataBase * dataBase;

@end

@implementation SQTrainingDateListDataManager

+ (instancetype)sharedInstance {
    static SQTrainingDateListDataManager *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [SQTrainingDateListDataManager new];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataBase = [SQTrainingDateListDataBase new];
    }
    return self;
}

- (NSArray *)dataSource {
    return self.data.copy;
}

- (void)fetchDataSourceWithCompletion:(nonnull void (^)(NSArray * _Nonnull))completion {
    NSAssert([NSThread isMainThread], @"main thread only, otherwise use lock to make thread safety");
    NSArray *data = self.data;
    if (!data) {
        data = [NSMutableArray array];
    }
    if (completion) {
        completion(data);
    }
}

@end
