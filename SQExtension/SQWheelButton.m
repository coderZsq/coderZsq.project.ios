//
//  SQWheelButton.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQWheelButton.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define kTOUCHBAND 25
#define kFirstImageOffset 2.5
#define kImageSeparation  10

@interface SQWheelButton ()

@property (nonatomic,strong) UIView         *controlView;

@property (nonatomic,strong) NSMutableArray *buttons;
@property (nonatomic,strong) NSTimer        *spinTimer;
@property (nonatomic,assign) NSInteger      numVisible;

@property (nonatomic,assign) CGPoint        radialCenter;
@property (nonatomic,assign) CGFloat        radius;
@property (nonatomic,assign) CGFloat        angle;
@property (nonatomic,assign) CGFloat        firstAngle;
@property (nonatomic,assign) CGFloat        delta;
@property (nonatomic,assign) CGFloat        fullSweep;
@property (nonatomic,assign) CGFloat        visibleArc;
@property (nonatomic,assign) CGFloat        decelerating;

@property (nonatomic,assign) BOOL           spinningWheel;

@end

@implementation SQWheelButton

- (instancetype)initWithFrame:(CGRect)frame buttonArray:(NSArray *)buttonArray arcCenter:(CGPoint)theCenter radius:(CGFloat)theRadius {
    self = [super initWithFrame:frame];
    if (self) {
        self.buttons=[NSMutableArray arrayWithArray:buttonArray];
        self.controlView = [[UIView alloc] initWithFrame:frame];
        [self configureWithArcCenter:theCenter radius:theRadius];
        [self assembleViews];
    }
    return self;
}

- (void)configureWithArcCenter:(CGPoint)theCenter radius:(CGFloat)theRadius {
    
    self.radialCenter = theCenter;
    self.radius       = theRadius;

    CGFloat temp1 = asin(([UIScreen mainScreen].bounds.size.width - self.radialCenter.x) / self.radius);
    CGFloat temp2 = -M_PI + acos((self.frame.size.height - self.radialCenter.y) / self.radius);

    self.visibleArc   = fabs(temp2 - temp1);
    self.angle        = 0;
    self.firstAngle   = temp1 - DEGREES_TO_RADIANS(kFirstImageOffset);
    self.delta        = DEGREES_TO_RADIANS(kImageSeparation);
    self.numVisible   = trunc(fabs(temp2 - self.firstAngle) / self.delta);
    self.fullSweep    = self.delta * self.buttons.count;
}

- (void)assembleViews {
    [self positionImages];
    for (UIButton * button in self.buttons) {
        [self.controlView addSubview:button];
    }
    [self addSubview:self.controlView];
}

- (void)clearSpin {
    self.decelerating = 0;
    self.spinningWheel = NO;
}

- (void)spinWheel {

    [self performSelector:@selector(repositionImagesWithDelta:) withObject:@(self.decelerating)];
    self.decelerating *= 0.9;
    if (fabs(self.decelerating) < 0.005) {
        [self clearSpin];
        [self.spinTimer invalidate];
        self.spinTimer=nil;
    }
}

- (void)repositionImagesWithDelta:(NSNumber *)increment {
    
    self.angle += [increment doubleValue];
    
    if (self.angle < (self.delta - self.fullSweep)) {
        self.angle += 2 * self.fullSweep;
    } else if (self.angle>(self.fullSweep-self.delta)) {
        self.angle -= 2 * self.fullSweep;
    }
    [self positionImages];
}

- (void)positionImages {
    
    for (int i = 0 ;i < self.buttons.count ;i++) {
        
        UIButton * button = self.buttons[i];
        CGFloat x,y,angle,offset;
        
        offset = self.angle - (self.delta * i);
        
        if (offset > 0) {
            offset -= self.fullSweep;
        } else if (offset<(-self.fullSweep)) {
            offset += self.fullSweep;
        }
        
        angle = self.firstAngle + offset;
        x     = self.radialCenter.x + sin(angle) * self.radius;
        y     = self.radialCenter.y - cos(angle) * self.radius;
        
        button.center = CGPointMake(x, y);
        button.alpha  = (CGRectContainsRect(self.controlView.bounds, button.frame)) ? 1.0 : 0.0;
    }
}

- (BOOL)pointTouchInBand:(CGPoint)point {
    return [self pointInCircle:self.radialCenter radius:self.radius + kTOUCHBAND point:point]&&![self pointInCircle:self.radialCenter radius:self.radius - kTOUCHBAND point:point];
}

- (BOOL)pointInCircle:(CGPoint)center radius:(CGFloat)cradius point:(CGPoint)point {
    return pow(point.x - center.x, 2) + pow(point.y - center.y, 2) <= pow(cradius, 2);
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (self.spinTimer) {
        [self.spinTimer invalidate];
        self.spinTimer = nil;
    }
    [self clearSpin];
    
    if ([touches count] == 1) {
        UITouch * touch = (UITouch*)[[touches objectEnumerator] nextObject];
        CGPoint point = [touch locationInView:self.controlView];
        if ([self pointTouchInBand:point]) {
            self.spinningWheel = YES;
        } else {
            [super touchesBegan:touches withEvent:event];
        }
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if ([touches count] >= 1) {
        UITouch * touch = (UITouch*)[[touches objectEnumerator] nextObject];
        CGPoint point = [touch locationInView:self.controlView];
        
        if (self.spinningWheel) {
            CGPoint lastPoint = [touch previousLocationInView:self.controlView];
            CGFloat x2 = asin((point.x - self.radialCenter.x) / (2 * self.radius));
            CGFloat x1 = asin((lastPoint.x - self.radialCenter.x) / (2 * self.radius));
            CGFloat y2 = M_PI - acos((point.y - self.radialCenter.y) / (2 * self.radius));
            CGFloat y1 = M_PI - acos((lastPoint.y - self.radialCenter.y) / (2 * self.radius));
            
            y2 = -y2;
            y1 = -y1;
            
            CGFloat approxDecelerating = 2 * MAX(x2-x1, y2-y1);
            
            self.decelerating = approxDecelerating;
            [self performSelector:@selector(repositionImagesWithDelta:) withObject:@(approxDecelerating)];
        } else {
            [super touchesMoved:touches withEvent:event];
        }
    } else {
        [super touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if ([touches count] >= 1) {
        if (self.spinningWheel) {
            if (fabs(self.decelerating)>0.0262) {
                self.spinTimer = [NSTimer timerWithTimeInterval:0.03 target:self selector:@selector(spinWheel) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.spinTimer forMode:NSDefaultRunLoopMode];
            } else {
                [self clearSpin];
            }
        } else {
            [super touchesEnded:touches withEvent:event];
        }
    }
    else {
        [super touchesEnded:touches withEvent:event];
    }
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self clearSpin];
    [super touchesCancelled:touches withEvent:event];
}

@end
