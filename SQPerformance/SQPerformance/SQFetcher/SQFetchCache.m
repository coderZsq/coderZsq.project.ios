//
//  SQFetchCache.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/8/23.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQFetchCache.h"
#import <CommonCrypto/CommonDigest.h>

@implementation SQFetchCache

+ (NSString *)sha1:(NSString *)inputString {
    NSData * data = [inputString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes,(unsigned int)data.length,digest);
    NSMutableString *outputString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [outputString appendFormat:@"%02x",digest[i]];
    }
    return [outputString lowercaseString];
}

@end
