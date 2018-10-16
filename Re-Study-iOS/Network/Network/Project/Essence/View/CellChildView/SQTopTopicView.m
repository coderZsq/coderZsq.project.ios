//
//  SQTopTopicView.m
//  Network
//
//  Created by 朱双泉 on 2018/10/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTopTopicView.h"

@implementation SQTopTopicView

+ (instancetype)viewForXib {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
