//
//  SQHttpConnection.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQFormData : NSObject

@property (nonatomic,strong) NSData * data;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * filename;

@property (nonatomic,copy) NSString * mimeType;

@end

@interface SQHttpConnection : NSObject

+ (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters formData:(NSArray *)formData success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
