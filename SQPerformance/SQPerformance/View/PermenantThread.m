//
//  PermenantThread.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "PermenantThread.h"

@interface Thread : NSThread
@end

@implementation Thread
- (void)dealloc {
    NSLog(@"%s", __func__);
}
@end

@interface PermenantThread()
@property (strong, nonatomic) Thread *innerThread;
@end

@implementation PermenantThread

- (instancetype)init
{
    if (self = [super init]) {
        self.innerThread = [[Thread alloc] initWithBlock:^{
            CFRunLoopSourceContext context = {0};
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            CFRelease(source);
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
        }];
        [self.innerThread start];
    }
    return self;
}


- (void)executeTask:(PermenantThreadTask)task {
    if (!self.innerThread || !task) return;
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}

- (void)stop {
    if (!self.innerThread) return;
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    [self stop];
}

- (void)__stop {
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

- (void)__executeTask:(PermenantThreadTask)task {
    task();
}

@end
