//
//  SQPictureTopicView.h
//  Network
//
//  Created by 朱双泉 on 2018/10/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQBaseTopicView.h"
#import <DALabeledCircularProgressView.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQPictureTopicView : SQBaseTopicView
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@end

NS_ASSUME_NONNULL_END
