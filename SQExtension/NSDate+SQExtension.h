//
//  NSDate+SQExtension.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SQExtension)

- (BOOL)isToday;

- (BOOL)isYesterday;

- (BOOL)isThisYear;

- (NSDate *)dateWithYMD;

- (NSDateComponents *)timeDifferenceNow;

@end
