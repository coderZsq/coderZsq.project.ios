//
//  SQDatePicker.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQDatePicker.h"

@interface SQDatePicker ()

@property (nonatomic,strong) NSDateFormatter * formatter;

@end

@implementation SQDatePicker

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDatePicker];
    }
    return self;
}

- (instancetype)initWithDateFormat:(NSString *)dateFormat {
    
    self = [super init];
    if (self) {
        [self setupDatePicker];
        [self setDateFormat:dateFormat];
    }
    return self;
}

+ (instancetype)pickerWithDateFormat:(NSString *)dateFormat {
    return [[self alloc]initWithDateFormat:dateFormat];
}

- (void)setupDatePicker {
    
    self.datePickerMode = UIDatePickerModeDate;
    self.timeZone       = [NSTimeZone systemTimeZone];
    self.maximumDate    = [NSDate date];
    [self addTarget:self action:@selector(pickerDate:) forControlEvents:UIControlEventValueChanged];
}

- (NSDateFormatter *)formatter {
    
    if (!_formatter) {
        _formatter = [NSDateFormatter new];
    }
    return _formatter;
}

- (void)setDateFormat:(NSString *)dateFormat {
    _dateFormat = dateFormat;
    [self.formatter setDateFormat:dateFormat];
    [self setMinimumDateFormat:self.minimumDateFormat];
}

- (void)setPickerDate:(NSString *)pickerDate {
    _pickerDate = pickerDate;
    [self setDate:[self.formatter dateFromString:pickerDate] animated:YES];
}

- (void)setMinimumDateFormat:(NSString *)minimumDateFormat {
    _minimumDateFormat = minimumDateFormat;
    [self setMinimumDate:[self.formatter dateFromString:minimumDateFormat]];
}

- (void)pickerDate:(UIDatePicker *)sender {
    
    if (self.block) {
        self.block ([self.formatter stringFromDate:[sender.date dateByAddingTimeInterval: [[NSTimeZone systemTimeZone] secondsFromGMTForDate: sender.date]]]);
    }
}

@end
