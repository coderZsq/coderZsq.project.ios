//
//  SQTrainingCapacityModel.h
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2019/1/2.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQTrainingCapacityRowModel : NSObject

@property (nonatomic, assign) NSInteger groups;

@property (nonatomic, assign) NSInteger times;

@property (nonatomic, assign) NSInteger weight;

- (NSDictionary *)modelToDictionary;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end

@interface SQTrainingCapacityModel : NSObject

@property (nonatomic, copy) NSString * action;

@property (nonatomic, strong) NSArray <SQTrainingCapacityRowModel *> * rows;

@property (nonatomic, assign) NSInteger capacity;

@end

NS_ASSUME_NONNULL_END
