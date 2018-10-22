//
//  NSDate+Date.m
//  Network
//
//  Created by 朱双泉 on 2018/10/22.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "NSDate+Date.h"

@implementation NSDate (Date)

- (BOOL)isThisYear {
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * createComponent = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDate * currentDate = [NSDate date];
    NSDateComponents * currrntComponent = [calendar components:NSCalendarUnitYear fromDate:currentDate];
    return createComponent.year == currrntComponent.year;
}

- (BOOL)isThisToday {
    NSCalendar * calendar = [NSCalendar currentCalendar];
    return [calendar isDateInToday:self];
}

- (BOOL)isThisYesterday {
    NSCalendar * calendar = [NSCalendar currentCalendar];
    return [calendar isDateInYesterday:self];
}

- (NSDateComponents *)detalWithNow {
    NSCalendar * calendar = [NSCalendar currentCalendar];
    return [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:self toDate:[NSDate date] options:NSCalendarWrapComponents];
}

@end
