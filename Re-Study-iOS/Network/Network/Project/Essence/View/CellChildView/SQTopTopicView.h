//
//  SQTopTopicView.h
//  Network
//
//  Created by 朱双泉 on 2018/10/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQBaseTopicView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQTopTopicView : SQBaseTopicView
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

NS_ASSUME_NONNULL_END
