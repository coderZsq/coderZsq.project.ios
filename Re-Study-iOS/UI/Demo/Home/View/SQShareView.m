//
//  SQShareView.m
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQShareView.h"
//#import "SQCoverView.h"

@implementation SQShareView

+ (instancetype)shareView {
    SQShareView * shareView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    CGRect frame = shareView.frame;
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height;
    shareView.frame = frame;
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
    [UIView animateWithDuration:.25 animations:^{
        CGRect frame = shareView.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        shareView.frame = frame;
    }];
    return shareView;
}

- (void)hiddenShareViewWhenCompletion:(void (^)(void))completion {
    [UIView animateWithDuration:.25 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
#if 0
        for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([view isKindOfClass:[SQCoverView class]]) {
                [view removeFromSuperview];
            }
        }
#endif
        if (completion) {
            completion();
        }
    }];
}

@end
