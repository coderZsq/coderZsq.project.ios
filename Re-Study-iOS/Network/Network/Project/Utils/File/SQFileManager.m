//
//  SQFileManager.m
//  Network
//
//  Created by 朱双泉 on 2018/10/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQFileManager.h"

@implementation SQFileManager

+ (void)getDirectorySize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileManager * manager = [NSFileManager defaultManager];
        BOOL isDirectory;
        BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
        if (!isExist || !isDirectory) {
            [[NSException exceptionWithName:@"FileError" reason:@"directoryPath is not exist or is not directory" userInfo:nil] raise];
        }
        NSArray * subpaths = [manager subpathsAtPath:directoryPath];
        NSInteger totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subpath];
            BOOL isDirectory;
            BOOL isExist = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) continue;
            if ([filePath containsString:@".DS"]) continue;
            NSDictionary *attr = [manager attributesOfItemAtPath:filePath error:nil];
            NSInteger size = [attr fileSize];
            totalSize += size;
        }
        if (completion) {
            completion(totalSize);
        }
    });
}

+ (void)removeDirectoryPath:(NSString *)directoryPath completion:(nonnull void (^)(void))completion{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileManager * manager = [NSFileManager defaultManager];
        BOOL isDirectory;
        BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
        if (!isExist || !isDirectory) {
            @throw [NSException exceptionWithName:@"FileError" reason:@"directoryPath is not exist or is not directory" userInfo:nil];
        }
        [manager removeItemAtPath:directoryPath error:nil];
        [manager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });
}

+ (void)directorySizeString:(NSString *)directoryPath completion:(void(^)(NSString *sizeString))completion {
    [SQFileManager getDirectorySize:directoryPath completion:^(NSInteger totalSize){
        NSString * text = @"Clear Memory";
        if (totalSize > 1000 * 1000) {
            text = [NSString stringWithFormat:@"%@(%.1fMB)", text, totalSize / 1000. / 1000.];
        } else if (totalSize > 1000) {
            text = [NSString stringWithFormat:@"%@(%.1fKB)", text, totalSize / 1000.];
        } else if (totalSize > 0) {
            text = [NSString stringWithFormat:@"%@(%liB)", text, totalSize];
        }
        text = [text stringByReplacingOccurrencesOfString:@".0" withString:@""];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(text);
            });
        }
    }];
}

@end
