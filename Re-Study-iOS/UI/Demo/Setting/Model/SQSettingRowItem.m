//
//  SQSettingRowItem.m
//  UI
//
//  Created by 朱双泉 on 2018/9/25.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSettingRowItem.h"

@implementation SQSettingRowItem

+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title {
    SQSettingRowItem * item = [SQSettingRowItem new];
    item.image = image;
    item.title = title;
    return item;
}

@end
