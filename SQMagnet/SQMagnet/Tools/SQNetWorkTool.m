//
//  SQNetWorkTool.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQNetWorkTool.h"
#import <AFNetworking.h>

@interface NSString (UTF8)
- (instancetype)UTF8;
@end

@implementation NSString (UTF8)

- (instancetype)UTF8 {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end

@implementation SQNetWorkTool

+ (void)requestInterface:(NSString *)interface parameters:(NSArray *)parameters callback:(void(^)(NSArray *results))callback {
    
    NSMutableString *URL = [@"http://127.0.0.1:5000" mutableCopy];
    [URL appendFormat: @"/%@", interface];
    [parameters enumerateObjectsUsingBlock:^(NSString *parameter, NSUInteger idx, BOOL * _Nonnull stop) {
        [URL appendFormat: @"/%@", [parameter UTF8]];
    }];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(responseObject[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
        callback(nil);
    }];
}

@end
