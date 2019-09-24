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
    return headerView;
}

@end
