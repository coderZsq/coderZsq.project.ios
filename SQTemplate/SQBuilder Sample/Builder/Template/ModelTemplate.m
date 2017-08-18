//
//  ModelTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "<#Unit#>Model.h"

@implementation <#Unit#>Model

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (<#Unit#>Model *)modelWithDictionary:(NSDictionary *)dictionary {
    return [[<#Unit#>Model alloc]initWithDictionary:dictionary];
}

@end
