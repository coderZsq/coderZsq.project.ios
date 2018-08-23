//
//  SQFetchCache.h
//  SQPerformance
//
//  Created by 朱双泉 on 2018/8/23.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQFetchCache : NSObject

+ (void)setCache:(NSData *)data key:(NSString *)key;

+ (id)getCacheFromKey:(NSString *)key;

+ (void)clearDiskCache;

@end
