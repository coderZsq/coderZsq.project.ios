//
//  SQFileManager.h
//  Network
//
//  Created by 朱双泉 on 2018/10/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQFileManager : NSObject

+ (NSInteger)getDirectorySize:(NSString *)directoryPath;
+ (void)removeDirectoryPath:(NSString *)directoryPath;
+ (NSString *)directorySizeString:(NSString *)directoryPath;

@end

NS_ASSUME_NONNULL_END
