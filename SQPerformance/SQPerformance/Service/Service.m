//
//  Service.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "Service.h"
#import <AFNetworking.h>

@implementation Service

- (void)fetchMockDataWithParam:(NSDictionary *)parameter completion:(RequestCompletionBlock)completion {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://localhost:8080/fetchMockData" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToString: @"success"]) {
            completion(responseObject[@"data"], nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

@end
