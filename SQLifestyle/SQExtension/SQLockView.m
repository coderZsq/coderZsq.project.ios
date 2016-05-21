//
//  SQLockView.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQLockView.h"

@interface SQLockView ()

@property (nonatomic,strong) NSMutableArray * locksArrM;
@property (nonatomic,assign) CGPoint currentMovePoint;

@end

@implementation SQLockView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeSubviews];
    }
    return self;
}

- (NSMutableArray *)locksArrM {
    
    if (!_locksArrM) {
        _locksArrM = @[].mutableCopy;
    }
    return _locksArrM;
}

- (void)initializeSubviews {
    
    for (int i = 0; i < 9; i++) {
        UIButton * lock = [UIButton new];
        lock.userInteractionEnabled = NO;
        lock.tag                    = i;
        [self addSubview:lock];
    }
}

- (void)setNormalImage:(UIImage *)normalImage {
    
    _normalImage = normalImage;
    [self.subviews enumerateObjectsUsingBlock:^(UIButton * lock, NSUInteger idx, BOOL * stop) {
        [lock setBackgroundImage:normalImage forState:UIControlStateNormal];
    }];
}

- (void)setHighlightImage:(UIImage *)highlightImage {
    
    _highlightImage = highlightImage;
    [self.subviews enumerateObjectsUsingBlock:^(UIButton * lock, NSUInteger idx, BOOL * stop) {
        [lock setBackgroundImage:highlightImage forState:UIControlStateSelected];
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton * lock = self.subviews[i];
        
        CGFloat lockW = 75;
        CGFloat lockH = lockW;
        
        int count = 3;
        int col   = i % count;
        int row   = i / count;
        CGFloat marginX = (self.frame.size.width - count * lockW) / (count + 1);
        CGFloat marginY = marginX;
        
        CGFloat lockX = marginX + col * (lockW + marginX);
        CGFloat lockY = row * (lockH + marginY);
        lock.frame = CGRectMake(lockX, lockY, lockW, lockH);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.currentMovePoint = CGPointZero;
    
    CGPoint point   = [self pointWithTouches:touches];
    UIButton * lock = [self lockWithPoint:point];
    
    if (lock && lock.selected == NO) {
        lock.selected = YES;
        [self.locksArrM addObject:lock];
    }
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint point   = [self pointWithTouches:touches];
    UIButton * lock = [self lockWithPoint:point];
    
    if (lock && lock.selected == NO) {
        lock.selected = YES;
        [self.locksArrM addObject:lock];
    } else {
        self.currentMovePoint = point;
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    if ([self.delegate respondsToSelector:@selector(lockView:didFinishPath:)]) {
        NSMutableString * path = [NSMutableString string];
        for (UIButton * lock in self.locksArrM) {
            [path appendFormat:@"%li", (long)lock.tag];
        }
        [self.delegate lockView:self didFinishPath:path];
    }
    for (UIButton * lock in self.locksArrM) {
        lock.selected = NO;
    }
    [self.locksArrM removeAllObjects];
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

- (CGPoint)pointWithTouches:(NSSet *)touches {
    UITouch * touch = [touches anyObject];
    return [touch locationInView:touch.view];
}

- (UIButton *)lockWithPoint:(CGPoint)point {
    
    for (UIButton * lock in self.subviews) {
        if (CGRectContainsPoint(lock.frame, point)) {
            return lock;
        }
    }   return nil;
}

- (void)drawRect:(CGRect)rect {
    
    if (self.locksArrM.count == 0) return;
    
    UIBezierPath * path = [UIBezierPath bezierPath];

    for (int i = 0; i < self.locksArrM.count; i++) {
        UIButton * lock = self.locksArrM[i];
        if (i == 0) {
            [path moveToPoint:lock.center];
        } else {
            [path addLineToPoint:lock.center];
        }
    }
    
    if (CGPointEqualToPoint(self.currentMovePoint, CGPointZero) == NO) {
        [path addLineToPoint:self.currentMovePoint];
    }
    
    path.lineWidth = 8;
    path.lineJoinStyle = kCGLineJoinBevel;
    [self.pathColor set];
    [path stroke];
}

@end
