//
//  SQConnectionPropertyCell.m
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/24.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQConnectionPropertyCell.h"

@implementation SQConnectionPropertyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.layer.cornerRadius = 4;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.iconImageView.layer.shadowOffset = CGSizeMake(2, 2);
    self.iconImageView.layer.shadowOpacity = 0.8;
}

@end
