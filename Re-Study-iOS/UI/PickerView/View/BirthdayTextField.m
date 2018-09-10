//
//  BirthdayTextField.m
//  UI
//
//  Created by 朱双泉 on 2018/9/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "BirthdayTextField.h"

@implementation BirthdayTextField

- (void)setDefaultText {
    [self dateChange:(UIDatePicker *)self.inputView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupKeyboard];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupKeyboard];
    }
    return self;
}

- (void)setupKeyboard {
    UIDatePicker * datePicker = [UIDatePicker new];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    self.inputView = datePicker;
}

- (void)dateChange:(UIDatePicker *)sender {
    NSDate * date = sender.date;
    NSDateFormatter * fmt = [NSDateFormatter new];
    fmt.dateFormat = @"yyyy-MM-dd";
    self.text = [fmt stringFromDate:date];
}

@end
