//
//  SQLoadingView.h
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/14.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQLoadingView : UIView

+ (instancetype)loadingView;

- (void)show;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
