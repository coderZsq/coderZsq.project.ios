//
//  ModelTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYSpecialSaleInterface.h"

@interface HYSpecialSaleModel : NSObject <HYSpecialSaleModelInterface>

@property (nonatomic,strong) NSArray * models;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (HYSpecialSaleModel *)modelWithDictionary:(NSDictionary *)dictionary;

@end
