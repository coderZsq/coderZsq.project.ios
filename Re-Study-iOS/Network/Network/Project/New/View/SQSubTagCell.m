//
//  SQSubTagCell.m
//  Network
//
//  Created by 朱双泉 on 2018/10/15.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSubTagCell.h"

@implementation SQSubTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    _iconImageView.layer.cornerRadius = _iconImageView.width * .5;
//    _iconImageView.layer.masksToBounds = YES;
}

+ (instancetype)cell {
    return [[[NSBundle mainBundle]loadNibNamed:@"SQSubTagCell" owner:nil options:nil] firstObject];
}

@end
