//
//  Proxy.m
//  UI
//
//  Created by 朱双泉 on 2018/9/6.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "Proxy.h"

@interface Proxy()
@property (nonatomic, weak) id target;
@end

@implementation Proxy

+ (instancetype)proxyWithTarget:(id)target {
    Proxy * proxy = [Proxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
