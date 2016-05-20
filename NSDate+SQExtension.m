//
//  NSDate+SQExtension.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "NSDate+SQExtension.h"

@implementation NSDate (SQExtension)

- (BOOL)isToday {
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    NSDateComponents * nowComponents  = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents * selfComponents = [calendar components:unit fromDate:self];

    return
    (selfComponents.year  == nowComponents.year) &&
    (selfComponents.month == nowComponents.month) &&
    (selfComponents.day   == nowComponents.day);
}

- (BOOL)isYesterday {
    
    NSDate * nowDate  = [[NSDate date] dateWithYMD];
    NSDate * selfDate = [self dateWithYMD];
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return components.day == 1;
}

- (NSDate *)dateWithYMD {
    
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter dateFromString:[formatter stringFromDate:self]];
}

- (BOOL)isThisYear {
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    NSDateComponents * nowComponents  = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents * selfComponents = [calendar components:unit fromDate:self];

    return nowComponents.year == selfComponents.year;
}

- (NSDateComponents *)timeDifferenceNow {
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

@end
