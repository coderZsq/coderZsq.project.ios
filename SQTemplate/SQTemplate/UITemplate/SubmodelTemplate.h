//
//  SubmodelTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubmodelInterfaceTemplate.h"

@interface SubmodelTemplate : NSObject <SubmodelInterfaceTemplate>

@property (nonatomic,copy) NSString * text;
@property (nonatomic,copy) NSString * detailText;
@property (nonatomic,copy) NSString * imageUrl;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (SubmodelTemplate *)modelWithDictionary:(NSDictionary *)dictionary;

@end
