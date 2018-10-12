//
//  SQBackView.h
//  Network
//
//  Created by 朱双泉 on 2018/10/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQBackView : UIView

+ (instancetype)backViewWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage target:(nullable id)target action:(nullable SEL)action title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
