//
//  SQAuthorizationManager.h
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQAuthorizationManager : NSObject

+ (void)fetchContacts: (void(^)(NSString *, NSArray *))callback;

@end

NS_ASSUME_NONNULL_END
