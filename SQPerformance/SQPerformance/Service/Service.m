//
//  Service.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "Service.h"
#import "SQFetcher.h"
#import <UIKit/UIKit.h>

@implementation Service

- (void)fetchMockDataWithParam:(NSDictionary *)parameter completion:(RequestCompletionBlock)completion {
    
    [SQFetchManager managerWithState:SQFetchSerialState]
    
    .GET(@"http://localhost:8090/fetchMockData", nil, ^(NSDictionary *responseObject){
        if ([responseObject[@"status"] isEqualToString: @"success"]) {
            completion(responseObject[@"data"], nil);
        }
        NSLog(@"EXCUTE: http://localhost:8090/fetchMockData");
    }, nil)
    
    .GET(@"http://localhost:8090/get", @{@"username": @"Castie!",
                                         @"passwd" : @"01234",
                                         @"param0" : @"0.0",
                                         @"param1" : @"1.1",
                                         @"param2" : @"2.2",
                                         @"param3" : @"3.3",
                                         @"param4" : @"4.4",
                                         }, ^(NSDictionary *responseObject){
             NSLog(@"EXCUTE: http://localhost:8090/get %@", responseObject);
    }, nil)
    
    .POST(@"http://localhost:8090/post", @{@"username": @"Castie!",
                                           @"passwd" : @"56789",
                                           @"param5" : @"5.5",
                                           @"param6" : @"6.6",
                                           @"param7" : @"7.7",
                                           @"param8" : @"8.8",
                                           @"param9" : @"9.9",
                                           }, ^(NSDictionary *responseObject){
              NSLog(@"EXCUTE: http://localhost:8090/post %@", responseObject);
    },nil)
    
    .GET(@"http://localhost:8090/image", nil, ^(UIImage *responseObject){
        NSLog(@"EXCUTE: http://localhost:8090/image %@", responseObject);
    },nil);
}

@end
