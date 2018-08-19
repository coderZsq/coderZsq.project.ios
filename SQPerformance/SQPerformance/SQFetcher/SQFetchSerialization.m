//
//  SQFetchSerialization.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/8/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQFetchSerialization.h"

@implementation SQFetchSerialization

+ (NSString *)getMethodSerializationWithParameters:(NSDictionary *)parameters {
    
    NSMutableString * parameterString = [NSMutableString string];
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString * key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString * value = (NSString *)obj;
        [parameterString appendFormat:@"%@=%@&", key, value];
    }];
    if (parameterString.length) {
        [parameterString insertString:@"?" atIndex:0];
        [parameterString deleteCharactersInRange:NSMakeRange(parameterString.length - 1, 1)];
    }
    return parameterString;
}

+ (NSData *)postMethodSerializationWithParameters:(NSDictionary *)parameters {

    NSMutableString * parameterString = [NSMutableString string];
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString * key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString * value = (NSString *)obj;
        [parameterString appendFormat:@"%@=%@&", key, value];
    }];
    if (parameterString.length) {
        [parameterString deleteCharactersInRange:NSMakeRange(parameterString.length - 1, 1)];
    }
    return [parameterString dataUsingEncoding:NSUTF8StringEncoding];
}

@end
