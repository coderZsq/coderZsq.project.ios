//
//  SQPictureTopicView.m
//  Network
//
//  Created by 朱双泉 on 2018/10/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQPictureTopicView.h"

@implementation SQPictureTopicView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.progressView.progressLabel.textColor = [UIColor lightGrayColor];
    self.progressView.progressTintColor = [UIColor whiteColor];
    self.progressView.trackTintColor = [UIColor colorWithWhite:1. alpha:.5];
    self.progressView.roundedCorners = 5;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.imageTouchBegin) {
        self.imageTouchBegin();
    }
}

@end
