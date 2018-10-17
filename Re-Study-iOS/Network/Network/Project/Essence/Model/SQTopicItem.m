//
//  SQTopicItem.m
//  Network
//
//  Created by 朱双泉 on 2018/10/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTopicItem.h"
#import <MJExtension.h>
#import "SQCommentItem.h"

@implementation SQTopicItem

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"top_cmt" : @"SQCommentItem"};
}

- (void)setTop_cmt:(NSArray *)top_cmt {
    _top_cmt = top_cmt;
    if (_top_cmt.count) {
        _topComment = top_cmt.firstObject;
    }
}

@end
