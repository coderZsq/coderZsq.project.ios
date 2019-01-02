//
//  SQTableTool.h
//  SqliteComponent_Example
//
//  Created by 朱双泉 on 2018/12/26.
//  Copyright © 2018 coderZsq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQTableTool : NSObject

+ (NSArray *)tableSortedColumnNames:(Class)cls uid:(NSString * _Nullable)uid;

+ (BOOL)isTableExists:(Class)cls uid:(NSString * _Nullable)uid;

@end

NS_ASSUME_NONNULL_END
