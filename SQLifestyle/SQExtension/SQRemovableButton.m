//
//  SQRemovableButton.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQRemovableButton.h"

@interface SQRemovableButton ()

@property (nonatomic,assign,getter = isMoved) BOOL moved;

@end

@implementation SQRemovableButton

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];
    
    self.moved = YES;
    
    UITouch * touch = [touches anyObject];
    CGPoint current = [touch locationInView:self];
    CGPoint previous = [touch previousLocationInView:self];
    
    CGPoint center = self.center;

    center.x += current.x - previous.x; center.y += current.y - previous.y;
    
    CGFloat screenWidth  = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat xMin = self.frame.size.width  * 0.5f; CGFloat xMax = screenWidth  - xMin;
    CGFloat yMin = self.frame.size.height * 0.5f; CGFloat yMax = screenHeight - yMin - 49;
    
    if (center.x > xMax) center.x = xMax; if (center.y > yMax) center.y = yMax;
    if (center.x < xMin) center.x = xMin; if (center.y < yMin) center.y = yMin;
    
    self.center = center;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!self.moved) {
        [super touchesEnded:touches withEvent:event];
    }
        self.moved = NO; if (!self.dockable) return;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat           x = self.frame.size.width * 0.5f;
    
    [UIView animateWithDuration:0.25f animations:^{
        CGPoint center = self.center;
        center.x = self.center.x > screenWidth * 0.5f ? screenWidth - x : x;
        self.center = center;
    }];
}

@end
