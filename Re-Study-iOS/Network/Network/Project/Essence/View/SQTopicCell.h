//
//  SQTopicCell.h
//  Network
//
//  Created by 朱双泉 on 2018/10/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQTopTopicView.h"
#import "SQPictureTopicView.h"
#import "SQVideoTopicView.h"
#import "SQVoiceTopicView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQTopicCell : UITableViewCell
@property (nonatomic, weak) SQTopTopicView * topView;
@property (nonatomic, weak) SQPictureTopicView * pictureView;
@property (nonatomic, weak) SQVideoTopicView * videoView;
@property (nonatomic, weak) SQVoiceTopicView * voiceView;
@end

NS_ASSUME_NONNULL_END
