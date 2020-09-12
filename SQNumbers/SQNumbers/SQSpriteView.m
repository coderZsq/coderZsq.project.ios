//
//  SQSpriteView.m
//  SQNumbers
//
//  Created by 朱双泉 on 2020/9/11.
//  Copyright © 2020 朱双泉. All rights reserved.
//

#import "SQSpriteView.h"
#import "SQRandoms.h"

@interface SQSpriteView ()

@property (nonatomic, strong) NSTimer *directionTimer;
@property (nonatomic, strong) NSTimer *frameTimer;

@end

@implementation SQSpriteView

- (void)dealloc {
    [self clearTimer];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self performSelector:@selector(updateCoordinate)
                   withObject:nil afterDelay:[SQRandoms randomNumberFrom:0 to:1 accuracy:8]];
    }
    return self;
}

- (void)clearTimer {
    [self.directionTimer invalidate];
    [self.frameTimer invalidate];
    self.directionTimer = nil;
    self.frameTimer = nil;
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
    
    NSTimeInterval randomInterval = [SQRandoms randomNumberFrom:1 to:3 accuracy:16];
    self.directionTimer = [NSTimer scheduledTimerWithTimeInterval: randomInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        direction = arc4random() % 9;
    }];
    
    self.frameTimer = [NSTimer scheduledTimerWithTimeInterval:0.03 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSInteger offset = 1;
        CGRect frame = self.frame;
        switch (direction) {
            case SQSpriteDirectionNone:
                break;
            case SQSpriteDirectionUp:
                frame.origin.y -= offset;
                break;
            case SQSpriteDirectionDown:
                frame.origin.y += offset;
                break;
            case SQSpriteDirectionLeft:
                frame.origin.x -= offset;
                break;
            case SQSpriteDirectionRight:
                frame.origin.x += offset;
                break;
            case SQSpriteDirectionLeftUp: {
                frame.origin.x -= offset;
                frame.origin.y -= offset;
            }   break;
            case SQSpriteDirectionRightUp: {
                frame.origin.x += offset;
                frame.origin.y -= offset;
            }   break;
            case SQSpriteDirectionLeftDown: {
                frame.origin.x -= offset;
                frame.origin.y += offset;
            }   break;
            case SQSpriteDirectionRightDown: {
                frame.origin.x += offset;
                frame.origin.y += offset;
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
    }];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self clearTimer];
    
    if (self.matched) return;
    
    [self.superview bringSubviewToFront:self];
    
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
        [self removeFromSuperview];
        [self clearTimer];
    } else {
        [self updateCoordinate];
    }
    if (self.matching) {
        self.matching(self);
    }
}

@end
