//
//  SQNavigationBar.m
//  Network
//
//  Created by 朱双泉 on 2018/10/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQNavigationBar.h"
#import "SQBackView.h"

@implementation SQNavigationBar

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView * view in self.subviews) {
        NSLog(@"%@", view);
        if ([view isKindOfClass:[SQBackView class]]) {
            view.x = 0;
        }
    }
}

@end
