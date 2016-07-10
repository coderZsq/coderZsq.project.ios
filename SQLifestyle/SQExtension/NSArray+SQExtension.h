//
//  NSArray+SQExtension.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SQExtension)

+ (NSArray *)arrayWithCountDownTime:(NSInteger)time;

- (NSString *)descriptionWithLocale:(id)locale;

@end
