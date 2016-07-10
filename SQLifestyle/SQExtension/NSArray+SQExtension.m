//
//  NSArray+SQExtension.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "NSArray+SQExtension.h"
#import <objc/runtime.h>

@implementation NSArray (SQExtension)

+ (NSArray *)arrayWithCountDownTime:(NSInteger)time {
    
    NSInteger hour, minute, second;
    hour = time / 3600; minute = time % 3600 / 60; second = time % 60;
    
    NSString * Hour   = [NSString stringWithFormat:hour   < 10 ? @"0%li" : @"%li",(long)hour  ];
    NSString * Minute = [NSString stringWithFormat:minute < 10 ? @"0%li" : @"%li",(long)minute];
    NSString * Second = [NSString stringWithFormat:second < 10 ? @"0%li" : @"%li",(long)second];
    
    return @[Hour,Minute,Second];
}

- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString * strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        [strM appendFormat:@"\t%@,\n",obj];
    }]; [strM appendString:@")"];
    return strM;
}

+ (void)load {

    SEL safeSel   = @selector(safeObjectAtIndex:);
    SEL unsafeSel = @selector(objectAtIndex:);
    
    Class class = NSClassFromString(@"__NSArrayI");

    Method safeMethod   = class_getInstanceMethod(class, safeSel);
    Method unsafeMethod = class_getInstanceMethod(class, unsafeSel);
    
    method_exchangeImplementations(unsafeMethod, safeMethod);
}

- (id)safeObjectAtIndex:(NSUInteger)index {

    if (index > (self.count - 1)) {
        NSAssert(NO, @"beyond the boundary");
        return nil;
    } else {
        return [self safeObjectAtIndex:index];
    }
}

@end
