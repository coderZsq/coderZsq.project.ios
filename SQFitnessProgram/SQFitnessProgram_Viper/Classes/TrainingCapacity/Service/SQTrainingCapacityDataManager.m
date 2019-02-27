//
//  SQTrainingCapacityDataManager.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/27.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingCapacityDataManager.h"
#import "SQTrainingCapacityDataBase.h"
#import "SQTrainingCapacityCellPresenter.h"
#import "SQTrainingCapacityModel.h"
#import "SQSqliteModelTool.h"

@interface SQTrainingCapacityDataManager ()

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) SQTrainingCapacityDataBase * dataBase;
@property (nonatomic, assign) NSInteger action;

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

- (NSString *)totalCapacity {
    NSInteger totalCapacity = 0;
    for (SQTrainingCapacityCellPresenter * p in self.dataSource) {
        totalCapacity += p.model.capacity;
    }
    return [NSString stringWithFormat:@"%ld", totalCapacity];
}

- (NSArray *)dataSource {
    return self.data.copy;
}

- (void)fetchDataSourceWithTitle:(NSString *)title type:(SQTrainingCapacityMuscleType)type completion:(nonnull void (^)(NSArray * _Nonnull))completion {
    NSAssert([NSThread isMainThread], @"main thread only, otherwise use lock to make thread safety");
    SQTrainingCapacityDataBase * dataBase = [SQSqliteModelTool queryModels:self.dataBase.class columnName:@"key" relation:(ColumnNameToValueRelationTypeEqual) value:[NSString stringWithFormat:@"%ld-%@", type, title] uid:nil].firstObject;
    if (!dataBase) {
        [self addTrainingAction];
        return;
    }
    NSMutableArray * dataSource = [NSMutableArray array];
    for (NSDictionary * d in dataBase.dataSource) {
        SQTrainingCapacityCellPresenter * p = [SQTrainingCapacityCellPresenter new];
        SQTrainingCapacityModel * m = [SQTrainingCapacityModel new];
        p.model = m;
        NSMutableArray * rows = [NSMutableArray array];
        for (NSDictionary * dr in d[@"rows"]) {
            SQTrainingCapacityRowModel * rm = [SQTrainingCapacityRowModel new];
            rm.groups = [dr[@"groups"] integerValue];
            rm.times = [dr[@"times"] integerValue];
            rm.weight = [dr[@"weight"] integerValue];
            [rows addObject:rm];
        }
        p.model.rows = rows;
        p.model.capacity = [d[@"capacity"] integerValue];
        p.model.action = [NSString stringWithFormat:@"%ld", ++self.action];
        [dataSource addObject:p];
    }
    self.data = dataSource;
    if (completion) {
        completion(self.data);
    }
}

- (void)storeDataSourceWithTitle:(NSString *)title type:(SQTrainingCapacityMuscleType)type dataSource:(NSArray *)dataSource completion:(void (^)(void))completion {
    self.dataBase.key = [NSString stringWithFormat:@"%ld-%@", type, title];
    self.dataBase.type = type;
    self.dataBase.date = title;
    NSMutableArray * tempDataSource = [NSMutableArray array];
    for (SQTrainingCapacityCellPresenter * p in dataSource) {
        NSMutableDictionary * md = [NSMutableDictionary dictionary];
        md[@"capacity"] = @(p.model.capacity);
        NSMutableArray * ma = [NSMutableArray array];
        for (SQTrainingCapacityRowModel * rm in p.model.rows) {
            NSMutableDictionary * mdr = [NSMutableDictionary dictionary];
            mdr[@"groups"] = @(rm.groups);
            mdr[@"times"] = @(rm.times);
            mdr[@"weight"] = @(rm.weight);
            [ma addObject:mdr];
        }
        md[@"rows"] = ma;
        [tempDataSource addObject:md];
    }
    self.dataBase.dataSource = tempDataSource;
    self.data = dataSource.mutableCopy;
    [SQSqliteModelTool saveOrUpdateModel:self.dataBase uid:nil];
}

- (void)addTrainingAction {
    SQTrainingCapacityCellPresenter * p = [SQTrainingCapacityCellPresenter new];
    p.model = [SQTrainingCapacityModel new];
    p.model.action = [NSString stringWithFormat:@"%ld", ++self.action];
    [self.data addObject:p];
}

@end
