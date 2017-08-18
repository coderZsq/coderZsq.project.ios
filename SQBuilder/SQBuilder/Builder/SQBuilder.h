//
//  SQBuilder.h
//  SQBuilder
//
//  Created by 朱双泉 on 17/08/2017.
//  Copyright © 2017 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQBuilder : NSObject

@property (nonatomic,copy) NSString * user;
@property (nonatomic,copy) NSString * prefix;
@property (nonatomic,copy) NSString * module;
@property (nonatomic,strong) NSDictionary * parameter;
@property (nonatomic,strong) NSDictionary * dataList;
@property (nonatomic,strong) NSArray * actionList;

+ (void)runWithFileParser:(NSDictionary *)config success:(void (^)())success failure:(void (^)())failure;

- (void)build;

@end
