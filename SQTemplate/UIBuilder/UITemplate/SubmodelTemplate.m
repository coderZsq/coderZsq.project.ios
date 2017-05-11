//
//  SubmodelTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "<#SubUnit#>Model.h"

@implementation <#SubUnit#>Model

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (<#SubUnit#>Model *)modelWithDictionary:(NSDictionary *)dictionary {
    return [[<#SubUnit#>Model alloc]initWithDictionary:dictionary];
}

@end
