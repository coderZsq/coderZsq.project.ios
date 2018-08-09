//
//  SQFetchManager.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/8/8.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQFetchManager.h"

@interface SQFetchManager()
@end

@implementation SQFetchManager

- (SQFetchManager *(^)(NSString *, NSDictionary *, void(^)(NSDictionary *), void(^)(NSError *)))GET {
    return ^(NSString * string, NSDictionary * parameter, void(^success)(NSDictionary *), void(^failure)(NSError *)){
        NSURL * url = [NSURL URLWithString:string];
        NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"GET";
        NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSError * err;
            NSDictionary * responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
            if(err) {
                failure(err);
            } else {
                success(responseObject);
            }
        }];
        [task resume];
        return self;
    };
}

+ (SQFetchManager *)managerWithState:(SQFetchState)state {
    return [SQFetchManager new];
}



@end
