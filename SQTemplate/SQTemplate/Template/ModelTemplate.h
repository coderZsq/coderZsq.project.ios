//
//  ModelTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterfaceTemplate.h"

@interface ModelTemplate : NSObject <ModelInterface>

@property (nonatomic,copy) NSString * text;
@property (nonatomic,copy) NSString * detailText;
@property (nonatomic,copy) NSString * imageUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (ModelTemplate *)modelWithDictionary:(NSDictionary *)dictionary;

@end
