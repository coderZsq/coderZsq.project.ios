//
//  SQBaseTopicView.m
//  Network
//
//  Created by 朱双泉 on 2018/10/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQBaseTopicView.h"

@implementation SQBaseTopicView

+ (instancetype)viewForXib {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
