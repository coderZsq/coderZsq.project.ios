//
//  SQFastLoginButton.m
//  Network
//
//  Created by 朱双泉 on 2018/10/15.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQFastLoginButton.h"

@implementation SQFastLoginButton

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.centerX = self.width * .5;
    self.imageView.y = 15;
    [self.titleLabel sizeToFit];
    self.titleLabel.centerX = self.width * .5;
    self.titleLabel.y = self.height - self.titleLabel.height;
}

@end
