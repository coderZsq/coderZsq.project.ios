//
//  SQCommentItem.m
//  Network
//
//  Created by 朱双泉 on 2018/10/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQCommentItem.h"
#import "SQUserItem.h"

@implementation SQCommentItem

- (NSString *)totalContent {
    return [NSString stringWithFormat:@"%@:%@", self.user.username, self.content];
}

@end
