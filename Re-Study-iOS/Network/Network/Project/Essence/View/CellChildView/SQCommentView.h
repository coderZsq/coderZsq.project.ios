//
//  SQCommentView.h
//  Network
//
//  Created by 朱双泉 on 2018/10/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQBaseTopicView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQCommentView : SQBaseTopicView
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

NS_ASSUME_NONNULL_END
