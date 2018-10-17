//
//  SQTopicCell.m
//  Network
//
//  Created by 朱双泉 on 2018/10/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTopicCell.h"

@implementation SQTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        SQTopTopicView * topView = [SQTopTopicView viewForXib];
        [self.contentView addSubview:topView];
        _topView = topView;
        SQPictureTopicView * pictureView = [SQPictureTopicView viewForXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
        SQVideoTopicView * videoView = [SQVideoTopicView viewForXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
        SQVoiceTopicView * voiceView = [SQVoiceTopicView viewForXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
        SQCommentView * commentView = [SQCommentView viewForXib];
        [self.contentView addSubview:commentView];
        _commentView = commentView;
    }
    return self;
}

@end
