//
//  NSString+SQExtension.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "NSString+SQExtension.h"
#import "NSArray+SQExtension.h"
#import "NSDate+SQExtension.h"

@implementation NSString (SQExtension)

+ (NSAttributedString *)stringStrikethroughForString:(NSString *)string color:(UIColor *)color {
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    [attributedString setAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid|NSUnderlineStyleSingle),   NSStrikethroughColorAttributeName : color} range:NSMakeRange(0, string.length)];
    return attributedString;
}

+ (NSString *)stringWithCurrentTimeFormat:(NSString *)format {
    
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:[NSDate date]];
}

+ (NSString *)stringWithCountDownTime:(NSInteger)time {
    
    NSMutableString * countDownStrM = @"".mutableCopy;
    NSArray * countDownArr = [NSArray arrayWithCountDownTime:time];
    for (int i = 0 ; i < countDownArr.count; i++) {
        [countDownStrM appendString:[NSString stringWithFormat:@":%@",countDownArr[i]]];
    }   return [countDownStrM substringFromIndex:1];
}

+ (NSDictionary *)stringWithJSONString:(NSString *)JSONString {
    NSError * error ;
    return [NSJSONSerialization JSONObjectWithData:[JSONString dataUsingEncoding:NSUTF8StringEncoding]
                                           options:NSJSONReadingMutableContainers error:&error];
}

- (void)makeTelephoneCall {
    NSString * num = self;
    NSMutableString * str = [[NSMutableString alloc]initWithFormat:@"tel:%@",num];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
}

- (NSString *)getDateFormatFromString:(NSString *)string {
    
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    formatter.locale     = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate * createDate  = [formatter dateFromString:string];
    
    if (createDate.isToday) {
        if (createDate.timeDifferenceNow.hour >= 1) {
            return [NSString stringWithFormat:@"%li小时前", (long)(createDate.timeDifferenceNow.hour)];
        } else if (createDate.timeDifferenceNow.minute >= 1) {
            return [NSString stringWithFormat:@"%li分钟前", (long)createDate.timeDifferenceNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createDate.isYesterday) {
        formatter.dateFormat = @"昨天 HH:mm";
        return [formatter stringFromDate:createDate];
    } else if (createDate.isThisYear) {
        formatter.dateFormat = @"MM-dd HH:mm";
        return [formatter stringFromDate:createDate];
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [formatter stringFromDate:createDate];
    }
}

- (CGSize)getSizeWithConstraint:(CGSize)Constraint font:(UIFont *)font {
    
    return [self boundingRectWithSize:Constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (BOOL)isValidateMobile {
    
    NSString * phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate * phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phonePredicate evaluateWithObject:self];
}

- (BOOL)isValidateEmail {
    
    NSString * emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate * emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:self];
}

- (BOOL)isValidateLicensePlate {
    
    NSString * licensePlateRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate * licensePlatePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",licensePlateRegex];
    return [licensePlatePredicate evaluateWithObject:self];
}

- (BOOL)isValidateCarModels {
    
    NSString * carModelsRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate * carModelsPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carModelsRegex];
    return [carModelsPredicate evaluateWithObject:self];
}

- (BOOL)isValidateUserName {
    
    NSString * userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:self];
}

- (BOOL)isValidatePassword {
    
    NSString * passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate * passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}

- (BOOL)isValidateNickname {

    NSString * nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate * nicknamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [nicknamePredicate evaluateWithObject:self];
}

- (BOOL)isValidateIdentityCard {
    
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString * identityCardregex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate * identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",identityCardregex];
    return [identityCardPredicate evaluateWithObject:self];
}

@end
