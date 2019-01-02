//
//  SQSqliteModelTool.h
//  SqliteComponent_Example
//
//  Created by 朱双泉 on 2018/12/26.
//  Copyright © 2018 coderZsq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ColumnNameToValueRelationType) {
    ColumnNameToValueRelationTypeMore,
    ColumnNameToValueRelationTypeLess,
    ColumnNameToValueRelationTypeEqual,
    ColumnNameToValueRelationTypeMoreEqual,
    ColumnNameToValueRelationTypeLessEqual
};

typedef enum : NSUInteger {
    SQSqliteModelToolNAONot,
    SQSqliteModelToolNAOAnd,
    SQSqliteModelToolNAOOr,
} SQSqliteModelToolNAO;

@interface SQSqliteModelTool : NSObject

+ (BOOL)createTable:(Class)cls uid:(NSString * _Nullable)uid;

+ (BOOL)isTableRequiredUpdate:(Class)cls uid:(NSString * _Nullable)uid;

+ (BOOL)updateTable:(Class)cls uid:(NSString * _Nullable)uid;

+ (BOOL)saveOrUpdateModel:(id)model uid:(NSString * _Nullable)uid;

+ (BOOL)deleteModel:(id)model uid:(NSString * _Nullable)uid;

+ (BOOL)deleteModel:(Class)cls whereStr:(NSString *)whereStr uid:(NSString * _Nullable)uid;

+ (BOOL)deleteModel:(Class)cls columnName:(NSString *)name relation:(ColumnNameToValueRelationType)relation value:(id)value uid:(NSString * _Nullable)uid;

+ (BOOL)deleteModel:(Class)cls keys: (NSArray *)keys relations: (NSArray *)relations values: (NSArray *)values nao: (NSArray *)naos uid: (NSString * _Nullable)uid;

+ (NSArray *)queryAllModels:(Class)cls uid:(NSString * _Nullable)uid;

+ (NSArray *)queryModels:(Class)cls columnName:(NSString *)name relation:(ColumnNameToValueRelationType)relation value:(id)value uid:(NSString * _Nullable)uid;

+ (NSArray *)queryModels:(Class)cls WithSql:(NSString *)sql uid:(NSString * _Nullable)uid;

+ (NSArray *)queryModels:(Class)cls keys: (NSArray *)keys relations: (NSArray *)relations values: (NSArray *)values nao: (NSArray *)naos uid: (NSString * _Nullable)uid;;

@end

NS_ASSUME_NONNULL_END
