//
//  Service.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "Service.h"
#import "SQFetchManager.h"

@implementation Service

- (void)fetchMockDataWithParam:(NSDictionary *)parameter completion:(RequestCompletionBlock)completion {
    
    [SQFetchManager managerWithState:SQFetchConcurrentState]
    .GET(@"http://localhost:8080/fetchMockData", nil, ^(NSDictionary *responseObject){
        if ([responseObject[@"status"] isEqualToString: @"success"]) {
            completion(responseObject[@"data"], nil);
        }
        NSLog(@"1111");
    }, nil)
    .GET(@"http://localhost:8080/test1", nil, ^(NSDictionary *responseObject){
        NSLog(@"2222");
    }, nil)
    .GET(@"http://localhost:8080/test2", nil, ^(NSDictionary *responseObject){
        NSLog(@"3333");
    },nil);
    
    NSLog(@"4444");
}

@end
