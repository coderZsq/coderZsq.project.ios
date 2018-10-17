//
//  SQTopicViewModel.h
//  Network
//
//  Created by 朱双泉 on 2018/10/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTopicItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQTopicViewModel : NSObject

@property (nonatomic, strong) SQTopicItem * item;

@property (nonatomic, assign) CGRect topViewFrame;
@property (nonatomic, assign) CGRect middleViewFrame;
@property (nonatomic, assign) CGFloat cellH;

@end

NS_ASSUME_NONNULL_END
