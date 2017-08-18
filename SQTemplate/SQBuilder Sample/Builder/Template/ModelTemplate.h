//
//  ModelTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "<#Unit#>Interface.h"

@interface <#Unit#>Model : NSObject <<#Unit#>ModelInterface>
<#ModelInterface#>

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (<#Unit#>Model *)modelWithDictionary:(NSDictionary *)dictionary;

@end
