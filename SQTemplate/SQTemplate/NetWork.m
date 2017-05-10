//
//  NetWork.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/8.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "NetWork.h"
#import <AFNetworking.h>

@implementation NetWork

+ (void)requestDataWithType:(MethodType)type URLString:(NSString *)URLString parameter:(NSDictionary *)parameter finishedCallBack:(void(^)(NSDictionary * result))finishedCallBack {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    if (type == MethodGetType) {
        [manager GET:URLString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finishedCallBack(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
           
        }];
        
    } else {
        [manager POST:URLString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finishedCallBack(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
}

@end
