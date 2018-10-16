//
//  SQTopicCell.m
//  Network
//
//  Created by 朱双泉 on 2018/10/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTopicCell.h"
#import "SQTopTopicView.h"

@implementation SQTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        SQTopTopicView * topView = [SQTopTopicView viewForXib];
        [self.contentView addSubview:topView];
    }
    return self;
}

@end
