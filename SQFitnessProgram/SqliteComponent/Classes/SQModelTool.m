//
//  SQModelTool.m
//  SqliteComponent_Example
//
//  Created by 朱双泉 on 2018/12/26.
//  Copyright © 2018 coderZsq. All rights reserved.
//

#import "SQModelTool.h"
#import <objc/runtime.h>
#import "SQModelProtocol.h"

@implementation SQModelTool

+ (NSString *)tableName:(Class)cls {
    return NSStringFromClass(cls);
}

+ (NSString *)tmpTableName:(Class)cls {
    return [NSStringFromClass(cls) stringByAppendingString:@"_tmp"];
}

+ (NSDictionary *)classIvarNameTypeDic:(Class)cls {
    unsigned int outCount = 0;
    Ivar * varList = class_copyIvarList(cls, &outCount);
    NSMutableDictionary * nameTypeDic = [NSMutableDictionary dictionary];
    NSArray * ignoreNames = nil;
    if ([cls respondsToSelector:@selector(ignoreColumnNames)]) {
        ignoreNames = [cls ignoreColumnNames];
    }
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = varList[i];
        NSString * ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if ([ivarName hasPrefix:@"_"]) {
            ivarName = [ivarName substringFromIndex:1];
        }
        if ([ignoreNames containsObject:ivarName]) {
            continue;
        }
        NSString * type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        type = [type stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"@\""]];
        [nameTypeDic setValue:type forKey: ivarName];
    }
    return nameTypeDic;
}

+ (NSDictionary *)classIvarNameSqliteTypeDic:(Class)cls {
    NSMutableDictionary * dic = [[self classIvarNameTypeDic:cls] mutableCopy];
    NSDictionary * typeDic = [self ocTypeToSqliteTypeDic];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
        dic[key] = typeDic[obj];
    }];
    return dic;
}

+ (NSString *)columnNamesAndTypesStr:(Class)cls {
    NSDictionary * nameTypeDic = [self classIvarNameSqliteTypeDic:cls];
    NSMutableArray * result = [NSMutableArray array];
    [nameTypeDic enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
        [result addObject:[NSString stringWithFormat:@"%@ %@", key, obj]];
    }];
    return [result componentsJoinedByString:@","];
}

+ (NSArray *)allTableSortedIvarNames:(Class)cls {
    NSDictionary * dic = [self classIvarNameTypeDic:cls];
    NSArray * keys = dic.allKeys;
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    return keys;
}

+ (NSDictionary *)ocTypeToSqliteTypeDic {
    return @{
             @"d" : @"real",
             @"f" : @"real",
             @"i" : @"integer",
             @"q" : @"integer",
             @"Q" : @"integer",
             @"B" : @"integer",
             @"NSData" : @"blob",
             @"NSDictionary" : @"text",
             @"NSMutableDictionary" : @"text",
             @"NSArray" : @"text",
             @"NSMutableArray" : @"text",
             @"NSString" : @"text"
             };
}

@end
