//
//  CircularSlider.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQCircularSlider.h"

@interface SQCircularSlider ()

@property (nonatomic, assign) CGPoint thumbCenterPoint;
@property (nonatomic, assign, getter = isContinuous) BOOL continuous;

@end

@implementation SQCircularSlider

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)setup {
    
    self.value                 = 0.0;
    self.minimumValue          = 0.0;
    self.maximumValue          = 1.0;
    self.lineWidth             = 4.0;
    self.thumbRadius           = 8.0;
    self.minimumTrackTintColor = [UIColor blueColor];
    self.maximumTrackTintColor = [UIColor greenColor];
    self.thumbTintColor        = [UIColor redColor];
    self.continuous            = YES;
    self.thumbCenterPoint      = CGPointZero;
    
    UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHappened:)];
    panGestureRecognizer.maximumNumberOfTouches = panGestureRecognizer.minimumNumberOfTouches;
    [self addGestureRecognizer:panGestureRecognizer];
}

float translateValueFromSourceIntervalToDestinationInterval(float sourceValue, float sourceIntervalMinimum, float sourceIntervalMaximum, float destinationIntervalMinimum, float destinationIntervalMaximum) {
    
    float a, b, destinationValue;
    
    a = (destinationIntervalMaximum - destinationIntervalMinimum) / (sourceIntervalMaximum - sourceIntervalMinimum);
    b = destinationIntervalMaximum - a * sourceIntervalMaximum;
    destinationValue = a * sourceValue + b;

    return destinationValue;
}

CGFloat angleBetweenThreePoints(CGPoint centerPoint, CGPoint p1, CGPoint p2) {
    
    CGPoint v1 = CGPointMake(p1.x - centerPoint.x, p1.y - centerPoint.y);
    CGPoint v2 = CGPointMake(p2.x - centerPoint.x, p2.y - centerPoint.y);
    CGFloat angle = atan2f(v2.x * v1.y - v1.x * v2.y, v1.x * v2.x + v1.y * v2.y);
    return angle;
}

- (void)setValue:(float)value {
    if (value != _value) {
        [self setNeedsDisplay];
        
        _value = value;
        
        [self sendActionsForControlEvents:UIControlEventValueChanged]; //给UIControl 增加事件
    }
}

- (void)setMinimumValue:(float)minimumValue {
    if (minimumValue != _minimumValue) {
        _minimumValue = minimumValue;
        if (self.maximumValue < self.minimumValue)	{ self.maximumValue = self.minimumValue; }
        if (self.value < self.minimumValue)			{ self.value = self.minimumValue; }
    }
}

- (void)setMaximumValue:(float)maximumValue {
    if (maximumValue != _maximumValue) {
        _maximumValue = maximumValue;
        if (self.minimumValue > self.maximumValue)	{ self.minimumValue = self.maximumValue; }
        if (self.value > self.maximumValue)			{ self.value = self.maximumValue; }
    }
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    if (![minimumTrackTintColor isEqual:_minimumTrackTintColor]) {
        _minimumTrackTintColor = minimumTrackTintColor;
        [self setNeedsDisplay];
    }
}

- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    if (![maximumTrackTintColor isEqual:_maximumTrackTintColor]) {
        _maximumTrackTintColor = maximumTrackTintColor;
        [self setNeedsDisplay];
    }
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor {
    if (![thumbTintColor isEqual:_thumbTintColor]) {
        _thumbTintColor = thumbTintColor;
        [self setNeedsDisplay];
    }
}

- (void)setLineWidth:(float)lineWidth {
    if (lineWidth != _lineWidth) {
        _lineWidth = lineWidth;
        [self setNeedsDisplay];
    }
}

- (void)setThumbRadius:(float)thumbRadius {
    if (thumbRadius != _thumbRadius) {
        _thumbRadius = thumbRadius;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint middlePoint;
    middlePoint.x = self.bounds.origin.x + self.bounds.size.width / 2;
    middlePoint.y = self.bounds.origin.y + self.bounds.size.height / 2;
    
    CGContextSetLineWidth(context, self.lineWidth);
    
    CGFloat radius = [self sliderRadius];
    
    [self.maximumTrackTintColor setStroke];
    [self drawCircularTrack:self.maximumValue atPoint:middlePoint withRadius:radius inContext:context];
    [self.minimumTrackTintColor setStroke];
    self.thumbCenterPoint = [self drawCircularTrack:self.value atPoint:middlePoint withRadius:radius inContext:context];
    
    [self.thumbTintColor setFill];
    [self drawThumbAtPoint:self.thumbCenterPoint inContext:context];
}

- (CGFloat)sliderRadius {
    CGFloat radius = MIN(self.bounds.size.width / 2, self.bounds.size.height / 2);
    radius -= MAX(self.lineWidth, self.thumbRadius);
    return radius;
}

- (void)drawThumbAtPoint:(CGPoint)sliderButtonCenterPoint inContext:(CGContextRef)context {
    
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, sliderButtonCenterPoint.x, sliderButtonCenterPoint.y);
    CGContextAddArc(context, sliderButtonCenterPoint.x, sliderButtonCenterPoint.y, self.thumbRadius, 0.0, 2 * M_PI, NO);
    
    CGContextFillPath(context);
    UIGraphicsPopContext();
}

- (CGPoint)drawCircularTrack:(float)track atPoint:(CGPoint)center withRadius:(CGFloat)radius inContext:(CGContextRef)context {
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    
    float angleFromTrack = translateValueFromSourceIntervalToDestinationInterval(track, self.minimumValue, self.maximumValue, 0, 2 * M_PI);
    
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = startAngle + angleFromTrack;
    CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, NO);
    
    CGPoint arcEndPoint = CGContextGetPathCurrentPoint(context);
    
    CGContextStrokePath(context);
    UIGraphicsPopContext();
    
    return arcEndPoint;
}

- (BOOL)isPointInThumb:(CGPoint)point {
    CGRect thumbTouchRect = CGRectMake(self.thumbCenterPoint.x - self.thumbRadius, self.thumbCenterPoint.y - self.thumbRadius, self.thumbRadius * 2, self.thumbRadius * 2);
    return CGRectContainsPoint(thumbTouchRect, point);
}

- (void)panGestureHappened:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    CGPoint tapLocation = [panGestureRecognizer locationInView:self];
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateChanged: {
            CGFloat radius = [self sliderRadius];
            CGPoint sliderCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
            CGPoint sliderStartPoint = CGPointMake(sliderCenter.x, sliderCenter.y - radius);
            CGFloat angle = angleBetweenThreePoints(sliderCenter, sliderStartPoint, tapLocation);
            
            if (angle < 0) {
                angle = -angle;
            } else {
                angle = 2 * M_PI - angle;
            }
            self.value = translateValueFromSourceIntervalToDestinationInterval(angle, 0, 2 * M_PI, self.minimumValue, self.maximumValue);
            break;
        }
        default:
            break;
    }
}

@end



