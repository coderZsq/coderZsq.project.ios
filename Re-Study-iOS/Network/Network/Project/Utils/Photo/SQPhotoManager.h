//
//  SQPhotoManager.h
//  Network
//
//  Created by 朱双泉 on 2018/10/29.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQPhotoManager : NSObject

+ (void)savePhoto:(UIImage *)image albumTitle:(NSString *)albumTitle completionHandler:(void(^)(BOOL success, NSError * error))completionHandler;

@end

NS_ASSUME_NONNULL_END
