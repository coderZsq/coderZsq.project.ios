//
//  SQSqliteTool.m
//  SqliteComponent_Example
//
//  Created by 朱双泉 on 2018/12/26.
//  Copyright © 2018 coderZsq. All rights reserved.
//

#import "SQSqliteTool.h"
#import "sqlite3.h"
#define kCachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
//#define kCachePath @"/Users/zhushuangquan/Desktop"

@implementation SQSqliteTool

sqlite3 *ppDb = nil;

+ (BOOL)deal:(NSString *)sql uid:(NSString *)uid {
    if (![self openDB:uid]) {
        NSLog(@"打开失败");
        return NO;
    }
    BOOL result = sqlite3_exec(ppDb, sql.UTF8String, nil, nil, nil) == SQLITE_OK;
    [self closeDB];
    return result;
}


+ (NSMutableArray <NSMutableDictionary *>*)querySql:(NSString *)sql uid:(NSString *)uid {
    [self openDB:uid];
    sqlite3_stmt *ppStmt = nil;
    if (sqlite3_prepare_v2(ppDb, sql.UTF8String, -1, &ppStmt, nil) != SQLITE_OK) {
        NSLog(@"准备语句编译失败");
        return nil;
    }
    NSMutableArray *rowDicArray = [NSMutableArray array];
    while (sqlite3_step(ppStmt) == SQLITE_ROW) {
        int columnCount = sqlite3_column_count(ppStmt);
        NSMutableDictionary * rowDic = [NSMutableDictionary dictionary];
        [rowDicArray addObject:rowDic];
        for (int i = 0; i < columnCount; i++) {
            const char * columnNameC = sqlite3_column_name(ppStmt, i);
            NSString * columnName = [NSString stringWithUTF8String:columnNameC];
            int type = sqlite3_column_type(ppStmt, i);
            id value = nil;
            switch (type) {
                case SQLITE_INTEGER:
                    value = @(sqlite3_column_int(ppStmt, i));
                    break;
                case SQLITE_FLOAT:
                    value = @(sqlite3_column_double(ppStmt, i));
                    break;
                case SQLITE_BLOB:
                    value = CFBridgingRelease(sqlite3_column_blob(ppStmt, i));
                    break;
                case SQLITE_NULL:
                    value = @"";
                    break;
                case SQLITE3_TEXT:
                    value = [NSString stringWithUTF8String: (const char *)sqlite3_column_text(ppStmt, i)];
                    break;
                    
                default:
                    break;
            }
            [rowDic setValue:value forKey:columnName];
        }
    }
    sqlite3_finalize(ppStmt);
    [self closeDB];
    return rowDicArray;
}

+ (BOOL)dealSqls:(NSArray<NSString *> *)sqls uid:(NSString *)uid {
    [self beginTransaction:uid];
    for (NSString * sql in sqls) {
        BOOL result = [self deal:sql uid:uid];
        if (result == NO) {
            [self rollBackTransaction:uid];
            return NO;
        }
    }
    [self commitTransaction:uid];
    return YES;
}

+ (void)beginTransaction:(NSString *)uid {
    [self deal:@"begin transaction" uid:uid];
}

+ (void)commitTransaction:(NSString *)uid {
    [self deal:@"commit transaction" uid:uid];
}

+ (void)rollBackTransaction:(NSString *)uid {
    [self deal:@"rollback transaction" uid:uid];
}

+ (BOOL)openDB:(NSString *)uid {
    NSString * dbName = @"common.sqlite";
    if (uid.length != 0) {
        dbName = [NSString stringWithFormat:@"%@.sqlite", uid];
    }
    NSString * dbPath = [kCachePath stringByAppendingPathComponent:dbName];
    return sqlite3_open(dbPath.UTF8String, &ppDb) == SQLITE_OK;
}

+ (void)closeDB {
    sqlite3_close(ppDb);
}

@end
