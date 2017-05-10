//
//  DataBase.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/8.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBase : NSObject

+ (DataBase *)shareInstance;
+ (void)cache:(Class)cls data:(NSDictionary *)data;
+ (void)requestDataWithClass:(Class)cls finishedCallBack:(void(^)(NSDictionary * response))finishedCallBack;

@end
