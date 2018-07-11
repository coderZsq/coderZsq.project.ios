//
//  PermenantThread.h
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PermenantThreadTask)(void);

@interface PermenantThread : NSThread

- (void)executeTask:(PermenantThreadTask)task;

- (void)stop;

@end
