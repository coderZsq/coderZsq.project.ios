//
//  SQModelTool.h
//  SqliteComponent_Example
//
//  Created by 朱双泉 on 2018/12/26.
//  Copyright © 2018 coderZsq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQModelTool : NSObject

+ (NSString *)tableName:(Class)cls;

+ (NSString *)tmpTableName:(Class)cls;

+ (NSDictionary *)classIvarNameTypeDic:(Class)cls;

+ (NSDictionary *)classIvarNameSqliteTypeDic:(Class)cls;

+ (NSString *)columnNamesAndTypesStr:(Class)cls;

+ (NSArray *)allTableSortedIvarNames:(Class)cls;

@end

NS_ASSUME_NONNULL_END
