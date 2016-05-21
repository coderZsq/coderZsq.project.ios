//
//  SQDatePicker.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SQDatePickerBlcok)(NSString *);

@interface SQDatePicker : UIDatePicker

@property (nonatomic,copy) NSString * dateFormat;

@property (nonatomic,copy) NSString * minimumDateFormat;

@property (nonatomic,copy) NSString * pickerDate;

@property (nonatomic,copy) SQDatePickerBlcok block;

- (instancetype)initWithDateFormat:(NSString *)dateFormat;

+ (instancetype)pickerWithDateFormat:(NSString *)dateFormat;

@end
