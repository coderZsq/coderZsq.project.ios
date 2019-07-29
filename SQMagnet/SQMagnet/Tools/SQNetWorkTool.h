//
//  SQNetWorkTool.h
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQNetWorkTool : NSObject

+ (void)requestInterface:(NSString *)interface parameters:(NSArray *)parameters callback:(void(^)(NSArray *results))callback;

@end

NS_ASSUME_NONNULL_END
