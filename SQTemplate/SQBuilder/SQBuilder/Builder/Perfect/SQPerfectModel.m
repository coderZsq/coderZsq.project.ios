//
//  ModelTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "SQPerfectModel.h"

@implementation SQPerfectModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (SQPerfectModel *)modelWithDictionary:(NSDictionary *)dictionary {
    return [[SQPerfectModel alloc]initWithDictionary:dictionary];
}

@end
