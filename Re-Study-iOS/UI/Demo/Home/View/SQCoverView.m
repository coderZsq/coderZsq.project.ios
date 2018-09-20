//
//  SQCoverView.m
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQCoverView.h"

@implementation SQCoverView

+ (instancetype)show {
    SQCoverView * view = [SQCoverView new];
    view.frame = [UIScreen mainScreen].bounds;
    view.backgroundColor = [UIColor blackColor];
    view.alpha = .3;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    return view;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(coverViewDidClosed:)]) {
        [self.delegate coverViewDidClosed:self];
    }
    if (self.didClosedBlock) {
        self.didClosedBlock(self);
    }
}

@end
