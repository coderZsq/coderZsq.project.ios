
//
//  Window.m
//  UI
//
//  Created by 朱双泉 on 2018/9/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "Window.h"

@implementation Window

TouchTest
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= .01) return nil;
    if (![self pointInside:point withEvent:event]) return nil;
    NSInteger count = self.subviews.count;
    for (NSInteger i = count - 1; i >= 0; i--) {
        UIView * subview = self.subviews[i];
        UIView * fitview = [subview hitTest:[self convertPoint:point toView:subview] withEvent:event];
        if (fitview) {
            return fitview;
        }
    }
    return self;
}

@end
