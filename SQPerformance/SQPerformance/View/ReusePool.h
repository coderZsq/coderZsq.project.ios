//
//  ReusePool.h
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReusePool : NSObject

- (NSObject *)dequeueReusableObject;

- (void)addUsingObject: (NSObject *)object;

- (void)reset;

@end
