//
//  NSString+SQExtension.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SQExtension)

+ (NSAttributedString *)stringStrikethroughForString:(NSString *)string color:(UIColor *)color;

+ (NSString *)stringWithCurrentTimeFormat:(NSString *)format;

+ (NSString *)stringWithCountDownTime:(NSInteger)time;

+ (NSDictionary *)stringWithJSONString:(NSString *)JSONString;

- (void)makeTelephoneCall;

- (NSString *)getDateFormatFromString:(NSString *)string;

- (CGSize)getSizeWithConstraint:(CGSize)Constraint font:(UIFont *)font;

- (BOOL)isValidateMobile;

- (BOOL)isValidateEmail;

- (BOOL)isValidateLicensePlate;

- (BOOL)isValidateCarModels;

- (BOOL)isValidateUserName;

- (BOOL)isValidatePassword;

- (BOOL)isValidateNickname;

- (BOOL)isValidateIdentityCard;

@end
