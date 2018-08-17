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
    
    [SQFetchManager managerWithState:SQFetchSerialState]
    .GET(@"http://localhost:8090/fetchMockData", nil, ^(NSDictionary *responseObject){
        if ([responseObject[@"status"] isEqualToString: @"success"]) {
            completion(responseObject[@"data"], nil);
        }
        NSLog(@"EXCUTE: http://localhost:8090/fetchMockData");
    }, nil)
    .GET(@"http://localhost:8090/test1", nil, ^(NSDictionary *responseObject){
        NSLog(@"EXCUTE: http://localhost:8090/test1");
    }, nil)
    .GET(@"http://localhost:8090/test2", nil, ^(NSDictionary *responseObject){
        NSLog(@"EXCUTE: http://localhost:8090/test2");
    },nil);
}

@end
