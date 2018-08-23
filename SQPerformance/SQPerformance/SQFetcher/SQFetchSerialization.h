//
//  SQFetchSerialization.h
//  SQPerformance
//
//  Created by 朱双泉 on 2018/8/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQFetchSerialization : NSObject

+ (NSString *)getMethodSerializationWithParameters:(NSDictionary *)parameters;

+ (NSData *)postMethodSerializationWithParameters:(NSDictionary *)parameters;

+ (id)serializationWithContentType:(NSString *)contentType data:(NSData *)data error:(NSError *)error;

@end
