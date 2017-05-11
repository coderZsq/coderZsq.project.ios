//
//  SubmodelTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "SubmodelTemplate.h"

@implementation SubmodelTemplate

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (SubmodelTemplate *)modelWithDictionary:(NSDictionary *)dictionary {
    return [[SubmodelTemplate alloc]initWithDictionary:dictionary];
}

@end
