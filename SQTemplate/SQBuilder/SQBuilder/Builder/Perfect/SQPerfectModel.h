//
//  ModelTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQPerfectInterface.h"

@interface SQPerfectModel : NSObject <SQPerfectModelInterface>

@property (nonatomic,assign) CGFloat vector;
@property (nonatomic,strong) NSDictionary * map;
@property (nonatomic,strong) NSArray * model;
@property (nonatomic,assign) NSInteger num;
@property (nonatomic,copy) NSString * name;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (SQPerfectModel *)modelWithDictionary:(NSDictionary *)dictionary;

@end
