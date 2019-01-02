//
//  SQTableTool.m
//  SqliteComponent_Example
//
//  Created by 朱双泉 on 2018/12/26.
//  Copyright © 2018 coderZsq. All rights reserved.
//

#import "SQTableTool.h"
#import "SQModelTool.h"
#import "SQSqliteTool.h"

@implementation SQTableTool

+ (NSArray *)tableSortedColumnNames:(Class)cls uid:(NSString *)uid {
    NSString * tableName = [SQModelTool tableName:cls];
    NSString * createSqlStr = [NSString stringWithFormat:@"select sql from sqlite_master where type = 'table' and name = '%@'", tableName];
    NSMutableDictionary * dic = [SQSqliteTool querySql:createSqlStr uid:uid].firstObject;
    NSString * createTableSql = dic[@"sql"];
    if (createTableSql.length == 0) {
        return nil;
    }
//    createTableSql = [createTableSql stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\"\n\t"]];
    createTableSql = [createTableSql stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    createTableSql = [createTableSql stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    createTableSql = [createTableSql stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    NSString * nameTypeStr = [createTableSql componentsSeparatedByString:@"("][1];
    NSArray * nameTypeArray = [nameTypeStr componentsSeparatedByString:@","];
    NSMutableArray * names = [NSMutableArray array];
    for (NSString * nameType in nameTypeArray) {
        if ([nameType containsString:@"primary"]) {
            continue;
        }
        NSString * nameType2 = [nameType stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
        NSString * name = [nameType2 componentsSeparatedByString:@" "].firstObject;
        [names addObject:name];
    }
    [names sortUsingComparator:^NSComparisonResult(NSString *  _Nonnull obj1, NSString *  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    return names;
}

+ (BOOL)isTableExists:(Class)cls uid:(NSString *)uid {
    NSString * tableName = [SQModelTool tableName:cls];
    NSString * queryCreateSqlStr = [NSString stringWithFormat:@"select sql from sqlite_master where type = 'table' and name = '%@'", tableName];
    NSMutableArray *result = [SQSqliteTool querySql:queryCreateSqlStr uid:uid];
    return result.count > 0;
}

@end
