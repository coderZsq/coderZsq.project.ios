//
//  SQSqliteTool.h
//  SqliteComponent_Example
//
//  Created by 朱双泉 on 2018/12/26.
//  Copyright © 2018 coderZsq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQSqliteTool : NSObject

+ (BOOL)deal: (NSString *)sql uid: (NSString * _Nullable)uid;

+ (NSMutableArray <NSMutableDictionary *> *)querySql: (NSString *)sql uid: (NSString * _Nullable)uid;

+ (BOOL)dealSqls:(NSArray <NSString *> *)sqls uid:(NSString *)uid;

@end

NS_ASSUME_NONNULL_END
