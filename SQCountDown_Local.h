//
//  SQCountDown_Local.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQCountDown_Local : NSObject

@property (nonatomic,assign) NSInteger second;

- (instancetype)initWithLabel:(UILabel *)label;

+ (instancetype)countDownWithLabel:(UILabel *)label;

@end
