//
//  SQSettingGroupItem.m
//  UI
//
//  Created by 朱双泉 on 2018/9/25.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSettingGroupItem.h"

@implementation SQSettingGroupItem

+ (instancetype)itemWithRowItems:(NSArray *)rowItems {
    SQSettingGroupItem * item = [SQSettingGroupItem new];
    item.rowItems = rowItems;
    return item;
}

@end
