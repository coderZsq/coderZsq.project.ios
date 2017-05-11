//
//  SubmodelTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "<#SubUnit#>ModelInterface.h"

@interface <#SubUnit#>Model : NSObject <<#SubUnit#>ModelInterface>
<#ModelInterface#>

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (<#SubUnit#>Model *)modelWithDictionary:(NSDictionary *)dictionary;

@end
