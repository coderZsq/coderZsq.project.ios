//
//  SQSqliteModelTool.m
//  SqliteComponent_Example
//
//  Created by 朱双泉 on 2018/12/26.
//  Copyright © 2018 coderZsq. All rights reserved.
//

#import "SQSqliteModelTool.h"
#import "SQModelTool.h"
#import "SQModelProtocol.h"
#import "SQSqliteTool.h"
#import "SQTableTool.h"

@implementation SQSqliteModelTool

+ (BOOL)createTable:(Class)cls uid:(NSString * )uid {
    NSString * tableName = [SQModelTool tableName:cls];
    if (![cls respondsToSelector:@selector(primaryKey)]) {
        NSLog(@"如果想要操作这个模型, 必须要实现+ (NSString *)primaryKey; 这个方法, 来告诉我主键信息");
        return NO;
    }
    NSString * primaryKey = [cls primaryKey];
    NSString * createTableSql = [NSString stringWithFormat:@"create table if not exists %@(%@, primary key(%@))", tableName, [SQModelTool columnNamesAndTypesStr:cls], primaryKey];
    return [SQSqliteTool deal:createTableSql uid:uid];
}

+ (BOOL)isTableRequiredUpdate:(Class)cls uid:(NSString *)uid {
    NSArray * modelNames = [SQModelTool allTableSortedIvarNames:cls];
    NSArray * tableNames = [SQTableTool tableSortedColumnNames:cls uid:uid];
    return ![modelNames isEqualToArray:tableNames];
}

+ (BOOL)updateTable:(Class)cls uid:(NSString *)uid {
    NSString * tmpTableName = [SQModelTool tmpTableName:cls];
    NSString * tableName = [SQModelTool tableName:cls];
    if (![cls respondsToSelector:@selector(primaryKey)]) {
        NSLog(@"如果想要操作这个模型, 必须要实现+ (NSString *)primaryKey;这个方法, 来告诉我主键信息");
        return NO;
    }
    NSMutableArray * execSqls = [NSMutableArray array];
    NSString * primaryKey = [cls primaryKey];
    NSString * createTableSql = [NSString stringWithFormat:@"create table if not exists %@(%@, primary key(%@));", tmpTableName, [SQModelTool columnNamesAndTypesStr:cls], primaryKey];
    [execSqls addObject:createTableSql];
    NSString * insertPrimaryKeyData = [NSString stringWithFormat:@"insert into %@(%@) select %@ from %@;", tmpTableName, primaryKey, primaryKey, tableName];
    [execSqls addObject:insertPrimaryKeyData];
    NSArray * oldNames = [SQTableTool tableSortedColumnNames:cls uid:uid];
    NSArray * newNames = [SQModelTool allTableSortedIvarNames:cls];
    NSDictionary * newNameToOldNameDic = nil;
    if ([cls respondsToSelector:@selector(newNameToOldNameDic)]) {
        newNameToOldNameDic = [cls newNameToOldNameDic];
    }
    for (NSString * columnName in newNames) {
        NSString * oldName = columnName;
        if ([newNameToOldNameDic[columnName] length] != 0) {
            oldName = newNameToOldNameDic[columnName];
        }
        if ((![oldNames containsObject:columnName] && ![oldNames containsObject:oldName]) || [columnName isEqualToString:primaryKey] ) {
            continue;
        }
        NSString * updateSql = [NSString stringWithFormat:@"update %@ set %@ = (select %@ from %@ where %@.%@ = %@.%@)", tmpTableName, columnName, oldName, tableName, tmpTableName, primaryKey, tableName, primaryKey];
        [execSqls addObject:updateSql];
    }
    NSString * deleteOldTable = [NSString stringWithFormat:@"drop table if exists %@", tableName];
    [execSqls addObject:deleteOldTable];
    NSString * renameTableName = [NSString stringWithFormat:@"alter table %@ rename to %@", tmpTableName, tableName];
    [execSqls addObject:renameTableName];
    return [SQSqliteTool dealSqls:execSqls uid:uid];
}

+ (BOOL)saveOrUpdateModel:(id)model uid:(NSString *)uid {
    Class cls = [model class];
    if (![SQTableTool isTableExists:cls uid:uid]) {
        [self createTable:cls uid:uid];
    }
    if ([self isTableRequiredUpdate:cls uid:uid]) {
        [self updateTable:cls uid:uid];
    }
    NSString * tableName = [SQModelTool tableName:cls];
    if (![cls respondsToSelector:@selector(primaryKey)]) {
        NSLog(@"如果想要操作这个模型, 必须要实现+ (NSString *)primaryKey;这个方法, 来告诉我主键信息");
        return NO;
    }
    NSString * primaryKey = [cls primaryKey];
    id primaryValue = [model valueForKeyPath:primaryKey];
    NSString * checkSql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'", tableName, primaryKey, primaryValue];
    NSArray * result = [SQSqliteTool querySql:checkSql uid:uid];
    NSArray * columnNames = [SQModelTool classIvarNameTypeDic:cls].allKeys;
    NSMutableArray * values = [NSMutableArray array];
    for (NSString * columnName in columnNames) {
        id value = [model valueForKeyPath:columnName];
        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            NSData * data = [NSJSONSerialization dataWithJSONObject:value options:NSJSONWritingPrettyPrinted error:nil];
            value = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        }
        if (value == nil) {
            value = @"";
        }
        [values addObject:value];
    }
    NSInteger count = columnNames.count;
    NSMutableArray * setValueArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        NSString * name = columnNames[i];
        id value = values[i];
        NSString * setStr = [NSString stringWithFormat:@"%@='%@'", name, value];
        [setValueArray addObject:setStr];
    }
    NSString * execSql = @"";
    if (result.count > 0) {
        execSql = [NSString stringWithFormat:@"update %@ set %@  where %@ = '%@'", tableName, [setValueArray componentsJoinedByString:@","], primaryKey, primaryValue];
    } else {
        execSql = [NSString stringWithFormat:@"insert into %@(%@) values('%@')", tableName, [columnNames componentsJoinedByString:@","], [values componentsJoinedByString:@"','"]];
    }
    return [SQSqliteTool deal:execSql uid:uid];
}

+ (BOOL)deleteModel:(id)model uid:(NSString *)uid {
    Class cls = [model class];
    NSString * tableName = [SQModelTool tableName:cls];
    if (![cls respondsToSelector:@selector(primaryKey)]) {
        NSLog(@"如果想要操作这个模型, 必须要实现+ (NSString *)primaryKey; 这个方法, 来告诉我主键信息");
        return NO;
    }
    NSString * primaryKey = [cls primaryKey];
    id primaryValue = [model valueForKeyPath:primaryKey];
    NSString * deleteSql = [NSString stringWithFormat:@"delete from %@ where %@ = '%@'", tableName, primaryKey, primaryValue];
    return [SQSqliteTool deal:deleteSql uid:uid];
}

+ (BOOL)deleteModel:(Class)cls whereStr:(NSString *)whereStr uid:(NSString *)uid {
    NSString * tableName = [SQModelTool tableName:cls];
    NSString * deleteSql = [NSString stringWithFormat:@"delete from %@ ", tableName];
    if (whereStr.length > 0) {
        deleteSql = [deleteSql stringByAppendingFormat:@"where %@", whereStr];
    }
    return [SQSqliteTool deal:deleteSql uid:uid];
}

+ (BOOL)deleteModel:(Class)cls columnName:(NSString *)name relation:(ColumnNameToValueRelationType)relation value:(id)value uid:(NSString *)uid {
    NSString * tableName = [SQModelTool tableName:cls];
    NSString * deleteSql = [NSString stringWithFormat:@"delete from %@ where %@ %@ '%@'", tableName, name, [self columnNameToValueRelationTypeDic][@(relation)], value];
    return [SQSqliteTool deal:deleteSql uid:uid];
}

+ (BOOL)deleteModel:(Class)cls keys: (NSArray *)keys relations: (NSArray *)relations values: (NSArray *)values nao: (NSArray *)naos uid: (NSString *)uid{
    NSMutableString *resultStr = [NSMutableString string];
    for (int i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        NSString *relationStr = [self columnNameToValueRelationTypeDic][relations[i]];
        id value = values[i];
        NSString *tempStr = [NSString stringWithFormat:@"%@ %@ '%@'", key, relationStr, value];
        [resultStr appendString:tempStr];
        if (i != keys.count - 1) {
            NSString *naoStr = [self naoTypeSQLRelation][naos[i]];
            [resultStr appendString:[NSString stringWithFormat:@" %@ ", naoStr]];
        }
    }
    NSString *tableName = [SQModelTool tableName:cls];
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@", tableName, resultStr];
    return  [SQSqliteTool deal:sql uid:uid];
}

+ (NSArray *)queryAllModels:(Class)cls uid:(NSString *)uid {
    NSString * tableName = [SQModelTool tableName:cls];
    NSString * sql = [NSString stringWithFormat:@"select * from %@", tableName];
    NSArray <NSDictionary *> * results = [SQSqliteTool querySql:sql uid:uid];
    return [self parseResults:results withClass:cls];
}

+ (NSArray *)queryModels:(Class)cls columnName:(NSString *)name relation:(ColumnNameToValueRelationType)relation value:(id)value uid:(NSString *)uid {
    NSString * tableName = [SQModelTool tableName:cls];
    NSString * sql = [NSString stringWithFormat:@"select * from %@ where %@ %@ '%@'", tableName, name, self.columnNameToValueRelationTypeDic[@(relation)], value];
    NSArray <NSDictionary *> * results = [SQSqliteTool querySql:sql uid:uid];
    return [self parseResults:results withClass:cls];
}

+ (NSArray *)queryModels:(Class)cls WithSql:(NSString *)sql uid:(NSString *)uid {
    NSArray <NSDictionary *> *results = [SQSqliteTool querySql:sql uid:uid];
    return [self parseResults:results withClass:cls];
}

+ (NSArray *)queryModels:(Class)cls keys: (NSArray *)keys relations: (NSArray *)relations values: (NSArray *)values nao: (NSArray *)naos uid: (NSString *)uid {
    NSMutableString *resultStr = [NSMutableString string];
    for (int i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        NSString *relationStr = [self columnNameToValueRelationTypeDic][relations[i]];
        id value = values[i];
        NSString *tempStr = [NSString stringWithFormat:@"%@ %@ '%@'", key, relationStr, value];
        [resultStr appendString:tempStr];
        if (i != keys.count - 1) {
            NSString *naoStr = [self naoTypeSQLRelation][naos[i]];
            [resultStr appendString:[NSString stringWithFormat:@" %@ ", naoStr]];
        }
    }
    NSString *tableName = [SQModelTool tableName:cls];
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@", tableName, resultStr];
    NSArray *rowDicArray = [SQSqliteTool querySql:sql uid:uid];
    NSArray *resultM = [self parseResults:rowDicArray withClass:cls];
    return resultM;
}

+ (NSArray *)parseResults:(NSArray <NSDictionary *> *)results withClass:(Class)cls {
    NSMutableArray * models = [NSMutableArray array];
    NSDictionary * nameTypeDic = [SQModelTool classIvarNameTypeDic:cls];
    for (NSDictionary * modelDic in results) {
        id model = [cls new];
        [models addObject:model];
        [modelDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSString * type = nameTypeDic[key];
            id resultValue = obj;
            if ([type isEqualToString:@"NSArray"] ||
                [type isEqualToString:@"NSDictionary"]) {
                NSData * data = [obj dataUsingEncoding:NSUTF8StringEncoding];
                resultValue = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            } else if ([type isEqualToString:@"NSMutableArray"] ||
                       [type isEqualToString:@"NSMutableDictionary"]) {
                NSData * data = [obj dataUsingEncoding:NSUTF8StringEncoding];
                resultValue = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            }
            [model setValue:resultValue forKey:key];
        }];
    }
    return models;
}

+ (NSDictionary *)columnNameToValueRelationTypeDic {
    return @{
             @(ColumnNameToValueRelationTypeMore) : @">",
             @(ColumnNameToValueRelationTypeLess) : @"<",
             @(ColumnNameToValueRelationTypeEqual) : @"=",
             @(ColumnNameToValueRelationTypeMoreEqual) : @">=",
             @(ColumnNameToValueRelationTypeLessEqual) : @"<="
             };
}

+ (NSDictionary *)naoTypeSQLRelation {
    return @{
             @(SQSqliteModelToolNAONot) : @"not",
             @(SQSqliteModelToolNAOAnd) : @"and",
             @(SQSqliteModelToolNAOOr) : @"or"
             };
    
}

@end

