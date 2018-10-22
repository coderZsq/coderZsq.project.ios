//
//  SQBottomView.h
//  Network
//
//  Created by 朱双泉 on 2018/10/22.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQBaseTopicView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQBottomView : SQBaseTopicView
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@end

NS_ASSUME_NONNULL_END
