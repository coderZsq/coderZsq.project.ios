//
//  ModelTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYSpecialSaleModel.h"

@implementation HYSpecialSaleModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (HYSpecialSaleModel *)modelWithDictionary:(NSDictionary *)dictionary {
    return [[HYSpecialSaleModel alloc]initWithDictionary:dictionary];
}

@end
