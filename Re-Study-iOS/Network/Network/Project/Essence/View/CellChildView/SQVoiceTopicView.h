//
//  SQVoiceTopicView.h
//  Network
//
//  Created by 朱双泉 on 2018/10/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQBaseTopicView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQVoiceTopicView : SQBaseTopicView
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

NS_ASSUME_NONNULL_END
