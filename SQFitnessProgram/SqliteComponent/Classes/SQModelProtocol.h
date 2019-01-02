//
//  SQModelProtocol.h
//  SqliteComponent_Example
//
//  Created by 朱双泉 on 2018/12/26.
//  Copyright © 2018 coderZsq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SQModelProtocol <NSObject>

@required
+ (NSString *)primaryKey;

@optional
+ (NSArray *)ignoreColumnNames;

+ (NSDictionary *)newNameToOldNameDic;

@end

NS_ASSUME_NONNULL_END
