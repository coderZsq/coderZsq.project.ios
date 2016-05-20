//
//  NSArray+SQExtension.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "NSArray+SQExtension.h"

@implementation NSArray (SQExtension)

+ (NSArray *)arrayWithCountDownTime:(NSInteger)time {
    
    NSInteger hour, minute, second;
    hour = time / 3600; minute = time % 3600 / 60; second = time % 60;
    
    NSString * Hour   = [NSString stringWithFormat:hour   < 10 ? @"0%li" : @"%li",hour  ];
    NSString * Minute = [NSString stringWithFormat:minute < 10 ? @"0%li" : @"%li",minute];
    NSString * Second = [NSString stringWithFormat:second < 10 ? @"0%li" : @"%li",second];
    
    return @[Hour,Minute,Second];
}

- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString * strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [strM appendFormat:@"\t%@,\n",obj];
    }]; [strM appendString:@")"];
    return strM;
}

- (id)objectAtIndexG:(NSUInteger)index {
    
    if (index < self.count) {
        return self[index];
    } else {
        return nil;
    }
}

@end
