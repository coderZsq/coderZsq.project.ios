//
//  NSObject+SQExtension.h
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/13.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SQExtension)

- (UIViewController *)getRootViewController;

- (UIViewController *)getCurrentViewController;

@end

NS_ASSUME_NONNULL_END
