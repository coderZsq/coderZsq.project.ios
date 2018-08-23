//
//  SQFetchCache.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/8/23.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQFetchCache.h"
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>

@interface SQFetchCache()
@property (nonatomic, strong) NSMutableDictionary * memoryCache;
@end

@implementation SQFetchCache

- (NSMutableDictionary *)memoryCache {
    
    if (!_memoryCache) {
        _memoryCache = @{}.mutableCopy;
    }
    return _memoryCache;
}

+ (instancetype)sharedInstance {
    static SQFetchCache * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

+ (void)setCache:(id)data key:(NSString *)key {
    if ([data isKindOfClass:[UIImage class]]) {
        [SQFetchCache sharedInstance].memoryCache[[self __sha1:key]] = data;
        [SQFetchCache __detectionDiskCache];
        NSString * homePath = NSHomeDirectory();
        NSString * path = [homePath stringByAppendingPathComponent:@"Library/Caches"];
        NSString * filePath = [path stringByAppendingPathComponent:[self __sha1:key]];
        [UIImagePNGRepresentation(data) writeToFile:filePath atomically:YES];
    }
}

+ (id)getCacheFromKey:(NSString *)key {
    id cache = [SQFetchCache sharedInstance].memoryCache[[self __sha1:key]];
    if (!cache) {
        NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString * file = [NSString stringWithFormat:@"%@/%@", cachePath, [self __sha1:key]];
        cache = [[UIImage alloc]initWithContentsOfFile:file];
    }
    return cache;
}

+ (void)__detectionDiskCache {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileManager * fileManager = [NSFileManager defaultManager];
        NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSDirectoryEnumerator * direnum = [fileManager enumeratorAtPath:cachePath];
        NSError * error = nil;
        NSString * filename;
        while (filename = [direnum nextObject]) {
            NSDictionary * fileAttributes = [fileManager attributesOfItemAtPath:[NSString stringWithFormat:@"%@/%@",cachePath, filename] error:&error];
            if (fileAttributes != nil) {
                NSNumber * fileSize = [fileAttributes objectForKey:NSFileSize];
                NSString * fileOwner = [fileAttributes objectForKey:NSFileOwnerAccountName];
                NSDate * fileModDate = [fileAttributes objectForKey:NSFileModificationDate];
                NSDate * fileCreateDate = [fileAttributes objectForKey:NSFileCreationDate];
                if (fileSize) {
                    NSLog(@"File size: %qi\n", [fileSize unsignedLongLongValue]);
                }
                if (fileOwner) {
                    NSLog(@"Owner: %@\n", fileOwner);
                }
                if (fileModDate) {
                    NSLog(@"Modification date: %@\n", fileModDate);
                }
                if (fileCreateDate) {
                    NSLog(@"create date:%@\n", fileModDate);
                }
            }
            else {
                NSLog(@"Path (%@) is invalid.", cachePath);
            }
        }
    });
}

+ (void)clearDiskCache {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",cachePath);
    NSDirectoryEnumerator * fileEnumerator = [fileManager enumeratorAtPath:cachePath];
    for (NSString * fileName in fileEnumerator) {
        NSString * filePath = [cachePath stringByAppendingPathComponent:fileName];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

+ (NSString *)__sha1:(NSString *)inputString {
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
