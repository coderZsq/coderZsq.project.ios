//
//  SQFileManager.m
//  Network
//
//  Created by 朱双泉 on 2018/10/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQFileManager.h"

@implementation SQFileManager

+ (NSInteger)getDirectorySize:(NSString *)directoryPath {
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
    return totalSize;
}

+ (void)removeDirectoryPath:(NSString *)directoryPath {
    NSFileManager * manager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
        @throw [NSException exceptionWithName:@"FileError" reason:@"directoryPath is not exist or is not directory" userInfo:nil];
    }
    [manager removeItemAtPath:directoryPath error:nil];
    [manager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (NSString *)directorySizeString:(NSString *)directoryPath {
    NSString * text = @"Clear Memory";
    NSInteger totalSize = [SQFileManager getDirectorySize:directoryPath];
    if (totalSize > 1000 * 1000) {
        text = [NSString stringWithFormat:@"%@(%.1fMB)", text, totalSize / 1000. / 1000.];
    } else if (totalSize > 1000) {
        text = [NSString stringWithFormat:@"%@(%.1fKB)", text, totalSize / 1000.];
    } else if (totalSize > 0) {
        text = [NSString stringWithFormat:@"%@(%liB)", text, totalSize];
    }
    text = [text stringByReplacingOccurrencesOfString:@".0" withString:@""];
    return text;
}

@end
