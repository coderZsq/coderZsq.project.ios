//
//  SQNumberPadHandleView.m
//  SQCleanBulk
//
//  Created by 朱双泉 on 2019/10/10.
//  Copyright © 2019 朱双泉. All rights reserved.
//

#import "SQNumberPadHandleView.h"

@implementation SQNumberPadHandleView

+ (instancetype)handleView {
    return [[NSBundle bundleForClass:self.class] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil].firstObject;
}

@end
