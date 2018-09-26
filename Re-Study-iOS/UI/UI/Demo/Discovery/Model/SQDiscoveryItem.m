//
//  SQDiscoveryItem.m
//  UI
//
//  Created by 朱双泉 on 2018/9/21.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQDiscoveryItem.h"
#import <MJExtension.h>

@implementation SQDiscoveryItem

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"themes" : @"SQDiscoveryThemeItem"};
}

+ (NSArray *)getDiscoveryList {
    return [SQDiscoveryItem mj_objectArrayWithFilename:@"Message.plist"];
}

@end
