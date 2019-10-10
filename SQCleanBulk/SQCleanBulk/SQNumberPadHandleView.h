//
//  SQNumberPadHandleView.h
//  SQCleanBulk
//
//  Created by 朱双泉 on 2019/10/10.
//  Copyright © 2019 朱双泉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQNumberPadHandleView : UIView

@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

+ (instancetype)handleView;

@end

NS_ASSUME_NONNULL_END
