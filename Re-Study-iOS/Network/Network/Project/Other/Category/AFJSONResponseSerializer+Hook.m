//
//  AFJSONResponseSerializer+Hook.m
//  Network
//
//  Created by 朱双泉 on 2018/10/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "AFJSONResponseSerializer+Hook.h"
#import <objc/runtime.h>

@implementation AFJSONResponseSerializer (Hook)

- (instancetype)hook_init {
    [self hook_init];
    self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    return self;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method m1 = class_getInstanceMethod(self, @selector(init));
        Method m2 = class_getInstanceMethod(self, @selector(hook_init));
        method_exchangeImplementations(m1, m2);
    });
}

@end
