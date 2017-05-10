//
//  DataBase.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/8.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "DataBase.h"

@implementation DataBase

+ (DataBase *)shareInstance {
    
    static DataBase * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataBase alloc]init];
    });
    return instance;
}

+ (NSString *)cacheWithClass:(Class)cls {
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", NSStringFromClass([cls class])]];
}

+ (void)cache:(Class)cls data:(NSDictionary *)data {
    [data writeToFile:[DataBase cacheWithClass:cls] atomically:YES];
}

+ (void)requestDataWithClass:(Class)cls finishedCallBack:(void(^)(NSDictionary * response))finishedCallBack {
    finishedCallBack([NSDictionary dictionaryWithContentsOfFile:[DataBase cacheWithClass:cls]]);
}



@end
