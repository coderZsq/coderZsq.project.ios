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
        _data = [NSMutableArray array];
        _dataBase = [SQTrainingDateListDataBase new];
    }
    return self;
}

- (NSArray *)dataSource {
    return self.data.copy;
}

- (void)fetchDataSourceWithType:(SQTrainingCapacityMuscleType)type completion:(void (^)(NSArray * _Nonnull))completion {
    NSAssert([NSThread isMainThread], @"main thread only, otherwise use lock to make thread safety");
    SQTrainingDateListDataBase * dataBase = [SQSqliteModelTool queryModels:self.dataBase.class columnName:@"type" relation:(ColumnNameToValueRelationTypeEqual) value:@(type) uid:nil].firstObject;
    [self.data removeAllObjects];
    [self.data addObjectsFromArray:dataBase.dateList];
    if (completion) {
        completion(self.data);
    }
}

- (void)storeDataSourceWithType:(SQTrainingCapacityMuscleType)type dataSource:(NSArray *)dataSource completion:(void (^)(void))completion {
    self.dataBase.type = type;
    self.dataBase.dateList = dataSource;
    [SQSqliteModelTool saveOrUpdateModel:self.dataBase uid:nil];
    if (completion) {
        completion();
    }
}

@end
