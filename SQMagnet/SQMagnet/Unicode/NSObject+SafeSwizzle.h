//
//  NSObject+SafeSwizzle.h
//  TestExample
//
//  Created by Apple on 2018/12/25.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (SafeSwizzle)

//交换对象方法
//+ (BOOL)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;
+ (BOOL)exchangeInstance:(Class)class selector:(SEL)originalSelector withSwizzledSelector: (SEL)swizzledSelector;

@end

