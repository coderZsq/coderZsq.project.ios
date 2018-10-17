//
//  SQTopicViewModel.m
//  Network
//
//  Created by 朱双泉 on 2018/10/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTopicViewModel.h"
#import "SQTopicItem.h"

@implementation SQTopicViewModel

- (void)setItem:(SQTopicItem *)item {
    _item = item;
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = [UIScreen mainScreen].bounds.size.width;
    CGFloat margin = 10;
    CGFloat textY = 55;
    CGFloat textW = [UIScreen mainScreen].bounds.size.width - 2 * margin;
    CGFloat textH = [item.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
    CGFloat topH = textY + textH;
    self.topViewFrame = CGRectMake(topX, topY, topW, topH);
    self.cellH = CGRectGetMaxY(self.topViewFrame) + margin;
    if (item.type != SQTopicItemTypeText) {
        CGFloat middleX = margin;
        CGFloat middleY = CGRectGetMaxY(self.topViewFrame) + margin;
        CGFloat middleW = textW;
        CGFloat middleH = textW / item.width * item.height;
        if (middleH > [UIScreen mainScreen].bounds.size.height) {
            middleH = 230;
            item.is_bigPicture = YES;
        }
        self.middleViewFrame = CGRectMake(middleX, middleY, middleW, middleH);
        self.cellH = CGRectGetMaxY(self.middleViewFrame) + margin;
    }
    if (item.topComment) {
        CGFloat commentX = 0;
        CGFloat commentY = self.cellH;
        CGFloat commentW = [UIScreen mainScreen].bounds.size.width;
        CGFloat commentH = 43;
        if (item.topComment.content.length) {
            CGFloat textH = [item.topComment.totalContent boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
            commentH = 21 + textH;
        }
        self.commentViewFrame = CGRectMake(commentX, commentY, commentW, commentH);
        self.cellH = CGRectGetMaxY(self.commentViewFrame) + margin;
    }
}

@end
