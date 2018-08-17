//
//  SQFetchManager.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/8/8.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQFetchManager.h"

@interface SQFetchManager()

@property (nonatomic,strong) NSOperation * preOperation;
@property (nonatomic,strong) NSOperationQueue * operationQueue;
@property (nonatomic,assign) SQFetchState state;

@end

@implementation SQFetchManager

- (NSOperationQueue *)operationQueue {
    
    if (!_operationQueue) {
        _operationQueue = [NSOperationQueue new];
        _operationQueue.maxConcurrentOperationCount = 6;
    }
    return _operationQueue;
}

- (SQFetchManager *(^)(NSString *, NSDictionary *, void(^)(NSDictionary *), void(^)(NSError *)))GET {
    return ^(NSString * URLString, NSDictionary * parameters, void(^success)(NSDictionary *), void(^failure)(NSError *)){
        NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
            dispatch_semaphore_t semaphore = NULL;
            if (self.state == SQFetchSerialState) semaphore = dispatch_semaphore_create(0);
            [[self dataTaskWithHTTPMethod:@"GET" URLString:URLString parameters:parameters success:success failure:failure semaphore:semaphore] resume];
            if (self.state == SQFetchSerialState) dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }];
        if (self.preOperation) {
            [operation addDependency:self.preOperation];
        }
        [self.operationQueue addOperation:operation];
        self.preOperation = operation;
        
        return self;
    };
}

- (SQFetchManager *(^)(NSString *, NSDictionary *, void (^)(NSDictionary *), void (^)(NSError *)))POST {
    return ^(NSString * URLString, NSDictionary * parameters, void(^success)(NSDictionary *), void(^failure)(NSError *)){
        NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
            dispatch_semaphore_t semaphore = NULL;
            if (self.state == SQFetchSerialState) semaphore = dispatch_semaphore_create(0);
            [[self dataTaskWithHTTPMethod:@"POST" URLString:URLString parameters:parameters success:success failure:failure semaphore:semaphore] resume];
            if (self.state == SQFetchSerialState) dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }];
        if (self.preOperation) {
            [operation addDependency:self.preOperation];
        }
        [self.operationQueue addOperation:operation];
        self.preOperation = operation;
        
        return self;
    };
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(NSDictionary *)parameters
                                         success:(void (^)(NSDictionary *))success
                                         failure:(void (^)(NSError *))failure
                                       semaphore:(dispatch_semaphore_t)semaphore {
    
    NSURL * url = [NSURL URLWithString:URLString];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = method;
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSError * err;
            NSDictionary * responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
            if(err) {
                failure(err);
                if (self.state == SQFetchSerialState) dispatch_semaphore_signal(semaphore);
            } else {
                success(responseObject);
                if (self.state == SQFetchSerialState) dispatch_semaphore_signal(semaphore);
            }
        }
    }];
    return task;
}

+ (SQFetchManager *)managerWithState:(SQFetchState)state {
    SQFetchManager * manager = [SQFetchManager new];
    manager.state = state;
    return manager;
}

@end
