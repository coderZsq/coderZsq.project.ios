//
//  SQSearchInputView.h
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/12.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQSearchInputView : UIView

+ (instancetype)inputView;

- (void)hookApplicationWillEnterForeground;

@end

NS_ASSUME_NONNULL_END
