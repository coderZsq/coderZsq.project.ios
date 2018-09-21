//
//  SQCityButton.m
//  UI
//
//  Created by 朱双泉 on 2018/9/21.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQCityButton.h"

@implementation SQCityButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 8;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.titleLabel.x > self.imageView.x) {
        self.titleLabel.x = self.imageView.x - 3;
        self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    }
}

@end
