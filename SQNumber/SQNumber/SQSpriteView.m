//
//  SQSpriteView.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQSpriteView.h"
#import "SQTimer.h"

@interface SQSpriteView ()

@property (nonatomic, copy) NSString *directionTimerId;
@property (nonatomic, copy) NSString *frameTimerId;

@end

@implementation SQSpriteView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self updateCoordinate];
    }
    return self;
}

typedef NS_ENUM(NSUInteger, SQSpriteDirection) {
    SQSpriteDirectionNone = 0,
    SQSpriteDirectionUp,
    SQSpriteDirectionDown,
    SQSpriteDirectionLeft,
    SQSpriteDirectionRight,
    SQSpriteDirectionLeftUp,
    SQSpriteDirectionRightUp,
    SQSpriteDirectionLeftDown,
    SQSpriteDirectionRightDown
};

- (void)updateCoordinate {
    __block NSInteger direction = 0;
        
    self.directionTimerId = [SQTimer execTask:^{
        direction = arc4random() % 9;
    } start:0 interval:2 repeats:YES async:NO];
    self.frameTimerId = [SQTimer execTask:^{
        CGRect frame = self.frame;
        switch (direction) {
            case SQSpriteDirectionNone:
                break;
            case SQSpriteDirectionUp:
                frame.origin.y -= 1;
                break;
            case SQSpriteDirectionDown:
                frame.origin.y += 1;
                break;
            case SQSpriteDirectionLeft:
                frame.origin.x -= 1;
                break;
            case SQSpriteDirectionRight:
                frame.origin.x += 1;
                break;
            case SQSpriteDirectionLeftUp: {
                frame.origin.x -= 1;
                frame.origin.y -= 1;
            }   break;
            case SQSpriteDirectionRightUp: {
                frame.origin.x += 1;
                frame.origin.y -= 1;
            }   break;
            case SQSpriteDirectionLeftDown: {
                frame.origin.x -= 1;
                frame.origin.y += 1;
            }   break;
            case SQSpriteDirectionRightDown: {
                frame.origin.x += 1;
                frame.origin.y += 1;
            }   break;
            default:
                break;
        }
        self.frame = frame;
        
        NSInteger margin = 5;
        if (self.frame.origin.x <= margin) {
            direction = SQSpriteDirectionRight;
        } else if (self.frame.origin.y <= margin) {
            direction = SQSpriteDirectionDown;
        } else if (self.frame.origin.x + self.bounds.size.width + margin >= self.superview.bounds.size.width) {
            direction = SQSpriteDirectionLeft;
        } else if (self.frame.origin.y + self.bounds.size.height + margin >= self.superview.bounds.size.height) {
            direction = SQSpriteDirectionUp;
        }
    } start:0 interval:0.03 repeats:YES async:NO];
}

- (void)clearTimer {
    [SQTimer cancelTask:self.directionTimerId];
    [SQTimer cancelTask:self.frameTimerId];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self clearTimer];
    
    if (self.matched) return;
    
    UITouch * touch = [touches anyObject];
    CGPoint current = [touch locationInView:self];
    CGPoint previous = [touch previousLocationInView:self];
    
    CGPoint center = self.center;
    center.x += current.x - previous.x; center.y += current.y - previous.y;
    
    CGFloat screenWidth  = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat xMin = self.frame.size.width  * 0.5; CGFloat xMax = screenWidth  - xMin;
    CGFloat yMin = self.frame.size.height * 0.5; CGFloat yMax = screenHeight - yMin;
    
    if (center.x > xMax) center.x = xMax; if (center.y > yMax) center.y = yMax;
    if (center.x < xMin) center.x = xMin; if (center.y < yMin) center.y = yMin;
    self.center = center;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.matched) return;
    
    _match = CGRectContainsRect(self.matchRect, self.frame);
    if (self.isMatch) {
        [self clearTimer];
    } else {
        [self updateCoordinate];
    }
    if (self.matching) {
        self.matching(self);
    }
}

@end
