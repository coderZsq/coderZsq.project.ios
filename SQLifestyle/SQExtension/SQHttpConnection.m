//
//  SQHttpConnection.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQHttpConnection.h"
//#import "AFNetworking.h"

@implementation SQFormData
@end

@implementation SQHttpConnection

+ (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
//    [[AFHTTPRequestOperationManager manager]POST:URLString parameters:parameters
//                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                             if (success) success(responseObject);
//                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                             if (failure) failure(error);
//                                         }];
}

+ (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters formData:(NSArray *)formDatas success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    

//    [[AFHTTPRequestOperationManager manager] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> multipartFormData) {
//        for (SQFormData * formData in formDatas) {
//            [multipartFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
//        }
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (success) success(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) failure(error);
//    }];
}

+ (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {

//    [[AFHTTPRequestOperationManager manager] GET:URLString parameters:parameters
//                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                             if (success) success(responseObject);
//                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                             if (failure) failure(error);
//                                         }];
}

@end
