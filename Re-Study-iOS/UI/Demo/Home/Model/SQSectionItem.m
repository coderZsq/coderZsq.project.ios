//
//  SQSectionItem.m
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSectionItem.h"
#import <MJExtension.h>

@implementation SQSectionItem

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"body" : @"SQHomeCellItem"};
}

+ (NSArray *)getSectionItem {
    return [SQSectionItem mj_objectArrayWithFilename:@"HomeDatas.plist"];
}

@end
