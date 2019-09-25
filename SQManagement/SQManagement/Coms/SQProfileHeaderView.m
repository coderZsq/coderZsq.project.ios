//
//  SQProfileHeaderView.m
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/24.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQProfileHeaderView.h"

@implementation SQProfileHeaderView

+ (instancetype)headerView {
    SQProfileHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
    headerView.profileImageView.layer.cornerRadius = 10;
    headerView.profileImageView.layer.masksToBounds = YES;
    headerView.profileImageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    headerView.profileImageView.layer.shadowOffset = CGSizeMake(5, 5);
    headerView.profileImageView.layer.shadowOpacity = 0.8;
    headerView.profileImageView.layer.shadowRadius = 4;
    return headerView;
}

@end
