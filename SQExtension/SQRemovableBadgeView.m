//
//  SQRemovableBadgeView.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQRemovableBadgeView.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat SQBadgeViewShadowRadius   = 1.0f;
static const CGFloat SQBadgeViewTextSideMargin = 8.0f;

@interface SQRemovableBadgeView ()

@property (strong, nonatomic) CAShapeLayer * shapeLayer;
@property (strong, nonatomic) UIView       * originView;

@end

@implementation SQRemovableBadgeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addGestureRecognizer];
        [self setMaxDistance:100.0f];
    }
    return self;
}

+ (void)initialize {
    
    if (self == [SQRemovableBadgeView class]) {
        [self initializeSettings];
    }
}

+ (void)initializeSettings {
    
    SQRemovableBadgeView * appearanceProxy = [SQRemovableBadgeView appearance];
    appearanceProxy.badgeTextColor         = [UIColor whiteColor];
    appearanceProxy.badgeTextFont          = [UIFont systemFontOfSize:12.0f];
    appearanceProxy.badgeBackgroundColor   = [UIColor redColor];
    appearanceProxy.badgeShadowSize        = CGSizeZero;
    appearanceProxy.badgeShadowColor       = [UIColor clearColor];
    appearanceProxy.badgeTextShadowColor   = [UIColor clearColor];
    appearanceProxy.badgeTextShadowSize    = CGSizeZero;
    appearanceProxy.badgeStrokeWidth       = 0.0f;
    appearanceProxy.badgeStrokeColor       = appearanceProxy.badgeBackgroundColor;
    appearanceProxy.backgroundColor        = [UIColor clearColor];
}

- (CGFloat)badgeViewCornerRadius{
    
    if (_badgeViewCornerRadius <= 0.0f) {
        return self.bounds.size.width * 0.5f;
    }
    return _badgeViewCornerRadius;
}

- (UIView *)originView {
    
    if (!_originView) {
        _originView = [UIView new];
        _originView.backgroundColor = self.badgeBackgroundColor;
        [self.superview insertSubview:_originView belowSubview:self];
    }
    return _originView;
}

- (CAShapeLayer *)shapeLayer {
    
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = self.badgeBackgroundColor.CGColor;
        [self.superview.layer insertSublayer:_shapeLayer below:self.layer];
    }
    return _shapeLayer;
}

- (void)addGestureRecognizer {
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                      action:@selector(badgeViewPanEvents:)]];
}

- (CGFloat)getMargin {
    return self.badgeStrokeWidth * 2.0f;
}

- (void)panToDisappear {
    [self.originView removeFromSuperview ]; self.originView = nil;
    [self.shapeLayer removeFromSuperlayer]; self.shapeLayer = nil;
}

- (CGSize)sizeOfTextForCurrentSettings {
    return [self.badgeText sizeWithAttributes:@{NSFontAttributeName:self.badgeTextFont}];
}

- (CGFloat)getDistanceFromPoint:(CGPoint)point currentPoint:(CGPoint)currentPoint {
    CGFloat offestX = point.x - currentPoint.x;
    CGFloat offestY = point.y - currentPoint.y;
    return sqrtf(offestX * offestX + offestY * offestY);
}

- (UIBezierPath *)pathFromOriginView:(UIView *)originView toBadgeView:(UIView *)badgeView {
    
    CGPoint originViewCenter = originView.center;
    CGFloat originViewX      = originViewCenter.x;
    CGFloat originViewY      = originViewCenter.y;
    CGFloat originViewRadius = originView.bounds.size.width * 0.5f;
    
    CGPoint badgeViewCenter  = badgeView.center;
    CGFloat badgeViewX       = badgeViewCenter.x;
    CGFloat badgeViewY       = badgeViewCenter.y;
    CGFloat badgeViewRadius  = badgeView.bounds.size.width * 0.5f;
    
    CGFloat distance = [self getDistanceFromPoint:self.originView.center currentPoint:self.center];
    
    CGFloat sin = distance ? (originViewX - badgeViewX) / distance : 0;
    CGFloat cos = distance ? (originViewY - badgeViewY) / distance : 1;
    
    CGPoint pointA = CGPointMake(badgeViewX  - badgeViewRadius  * cos , badgeViewY  + badgeViewRadius  * sin);
    CGPoint pointB = CGPointMake(badgeViewX  + badgeViewRadius  * cos , badgeViewY  - badgeViewRadius  * sin);
    CGPoint pointC = CGPointMake(originViewX + originViewRadius * cos , originViewY - originViewRadius * sin);
    CGPoint pointD = CGPointMake(originViewX - originViewRadius * cos , originViewY + originViewRadius * sin);
    CGPoint pointO = CGPointMake(pointA.x + distance * 0.5f * sin , pointA.y + distance * 0.5f * cos);
    CGPoint pointP = CGPointMake(pointB.x + distance * 0.5f * sin , pointB.y + distance * 0.5f * cos);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:   pointA];
    [path addLineToPoint:pointB];
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    [path addLineToPoint:pointD];
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    return path;
}

- (void)drawRect:(CGRect)rect {
    
    if (self.badgeText.length) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGFloat margin       = [self getMargin];
        CGRect rectToDraw    = CGRectInset(rect, margin, margin);
        
        UIBezierPath *borderPath   = [UIBezierPath bezierPathWithRoundedRect:rectToDraw byRoundingCorners:(UIRectCorner)UIRectCornerAllCorners cornerRadii:CGSizeMake(self.badgeViewCornerRadius, self.badgeViewCornerRadius)];
        
        CGContextSaveGState(context); {
            CGContextAddPath(context, borderPath.CGPath);
            CGContextSetFillColorWithColor(context, self.badgeBackgroundColor.CGColor);
            CGContextSetShadowWithColor(context, self.badgeShadowSize, SQBadgeViewShadowRadius, self.badgeShadowColor.CGColor);
            CGContextDrawPath(context, kCGPathFill);
        }   CGContextRestoreGState(context);
        
        CGContextSaveGState(context); {
            CGContextAddPath(context, borderPath.CGPath);
            CGContextSetLineWidth(context, self.badgeStrokeWidth);
            CGContextSetStrokeColorWithColor(context, self.badgeStrokeColor.CGColor);
            CGContextDrawPath(context, kCGPathStroke);
        }   CGContextRestoreGState(context);
        
        CGContextSaveGState(context); {
            CGContextSetFillColorWithColor(context, self.badgeTextColor.CGColor);
            CGContextSetShadowWithColor(context, self.badgeTextShadowSize, 1.0, self.badgeTextShadowColor.CGColor);
            
            CGRect textFrame = rectToDraw;
            CGSize textSize  = [self sizeOfTextForCurrentSettings];
            
            textFrame.size.height = textSize.height;
            textFrame.origin.y    = rectToDraw.origin.y + ceilf((rectToDraw.size.height - textFrame.size.height) * 0.5f);
            
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            [self.badgeText drawInRect:textFrame withAttributes:@{NSFontAttributeName           :self.badgeTextFont,
                                                                  NSForegroundColorAttributeName:self.badgeTextColor,
                                                                  NSParagraphStyleAttributeName :paragraphStyle,}];
        }   CGContextRestoreGState(context);
    }
}

- (void)badgeViewPanEvents:(UIPanGestureRecognizer *) panGesture{
    
    CGPoint panPoint = [panGesture translationInView:self];
    
    CGPoint changeCenter = self.center;
    changeCenter.x += panPoint.x;
    changeCenter.y += panPoint.y;
    self.center = changeCenter;
    
    [panGesture setTranslation:CGPointZero inView:self];
    
    CGFloat distance = [self getDistanceFromPoint:self.center currentPoint:self.originView.center];
    
    if (distance < self.maxDistance) {
        CGFloat cornerRadius = self.badgeViewCornerRadius;
        CGFloat smallCircleRadius = cornerRadius - distance / 20;
        self.originView.bounds = CGRectMake(0, 0, smallCircleRadius * (2 - 0.5f), smallCircleRadius * (2 - 0.5f));
        self.originView.layer.cornerRadius = self.originView.bounds.size.width * 0.5f;
        
        if (!self.originView.hidden && distance > 0) {
            self.shapeLayer.path = [self pathFromOriginView:self toBadgeView:self.originView].CGPath;
        }
        
    } else {
        [self.shapeLayer removeFromSuperlayer];
        self.shapeLayer = nil;
        self.originView.hidden = YES;
    }
    
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        
        if (distance > self.maxDistance) {
            [self panToDisappear];
            
            [UIView animateWithDuration:0.25f animations:^{
                self.alpha = 0.0f;
            }completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
            
        } else {
            
            [self.shapeLayer removeFromSuperlayer]; self.shapeLayer = nil;
            
            [UIView animateWithDuration:0.25f delay:0 usingSpringWithDamping:0.25f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.center = self.originView.center;
            } completion:^(BOOL finished) {
                self.originView.hidden = NO;
            }];
        }
    }
}

- (void)setBadgeViewAlignment:(SQBadgeViewAlignment)badgeViewAlignment {
    
    if (badgeViewAlignment != _badgeViewAlignment) {
        _badgeViewAlignment = badgeViewAlignment;
        [self setNeedsLayout];
    }
}

- (void)setBadgePositionAdjustment:(CGPoint)badgePositionAdjustment {
    _badgePositionAdjustment = badgePositionAdjustment;
    [self setNeedsLayout];
}

- (void)setBadgeText:(NSString *)badgeText {
    
    if (badgeText != _badgeText) {
        _badgeText = badgeText.copy;
        [self setNeedsDisplay];
    }
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    
    if (badgeTextColor != _badgeTextColor) {
        _badgeTextColor = badgeTextColor;
        [self setNeedsDisplay];
    }
}

- (void)setBadgeTextShadowColor:(UIColor *)badgeTextShadowColor {
    
    if (badgeTextShadowColor != _badgeTextShadowColor) {
        _badgeTextShadowColor = badgeTextShadowColor;
        [self setNeedsDisplay];
    }
}

- (void)setBadgeTextShadowSize:(CGSize)badgeTextShadowSize {
    _badgeTextShadowSize = badgeTextShadowSize;
    [self setNeedsDisplay];
}


- (void)setBadgeTextFont:(UIFont *)badgeTextFont {
    if (badgeTextFont != _badgeTextFont) {
        _badgeTextFont = badgeTextFont;
        [self setNeedsDisplay];
    }
}

- (void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor {
    
    if (badgeBackgroundColor != _badgeBackgroundColor) {
        _badgeBackgroundColor = badgeBackgroundColor;
        [self setNeedsDisplay];
    }
}

- (void)setBadgeStrokeWidth:(CGFloat)badgeStrokeWidth {
    
    if (badgeStrokeWidth != _badgeStrokeWidth) {
        _badgeStrokeWidth = badgeStrokeWidth;
        [self setNeedsDisplay];
    }
}

- (void)setBadgeStrokeColor:(UIColor *)badgeStrokeColor {
    
    if (badgeStrokeColor != _badgeStrokeColor) {
        _badgeStrokeColor = badgeStrokeColor;
        [self setNeedsDisplay];
    }
}

- (void)setBadgeShadowColor:(UIColor *)badgeShadowColor {
    
    if (badgeShadowColor != _badgeShadowColor) {
        _badgeShadowColor = badgeShadowColor;
        [self setNeedsDisplay];
    }
}

- (void)setBadgeShadowSize:(CGSize)badgeShadowSize {
    
    if (!CGSizeEqualToSize(badgeShadowSize, _badgeShadowSize)) {
        _badgeShadowSize = badgeShadowSize;
        [self setNeedsDisplay];
    }
}

- (void)setAttachView:(UIView *)attachView {
    _attachView = attachView;
    [self.attachView.superview insertSubview:self aboveSubview:self.attachView];
}

- (void)setPanable:(BOOL)panable {
    _panable = panable;
    self.userInteractionEnabled = _panable;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect  frame      = self.frame;
    CGFloat textWidth  = [self sizeOfTextForCurrentSettings].width;
    CGFloat textHeight = [self sizeOfTextForCurrentSettings].height;
    CGFloat margin     = [self getMargin];
    CGFloat viewWidth  = MAX(_badgeMinWidth, textWidth + SQBadgeViewTextSideMargin + (margin * 2));
    CGFloat viewHeight = MAX(24, textHeight + (margin * 2));
    frame.size.width   = MAX(viewWidth, viewHeight);
    frame.size.height  = MAX(viewWidth, viewHeight);
    
    if (self.attachView) {
        CGPoint center         = self.center;
        CGRect  attachViewFrame = self.attachView.frame;
        
        switch (self.badgeViewAlignment) {
            case SQBadgeViewAlignmentTopLeft:
                center.x = attachViewFrame.origin.x;
                center.y = attachViewFrame.origin.y;
                break;
            case SQBadgeViewAlignmentTopRight:
                center.x = attachViewFrame.origin.x + attachViewFrame.size.width;
                center.y = attachViewFrame.origin.y;
                break;
            case SQBadgeViewAlignmentTopCenter:
                center.x = attachViewFrame.origin.x + attachViewFrame.size.width * 0.5f;
                center.y = attachViewFrame.origin.y;
                break;
            case SQBadgeViewAlignmentCenterLeft:
                center.x = attachViewFrame.origin.x;
                center.y = attachViewFrame.origin.y + attachViewFrame.size.height * 0.5f;
                break;
            case SQBadgeViewAlignmentCenterRight:
                center.x = attachViewFrame.origin.x + attachViewFrame.size.width;
                center.y = attachViewFrame.origin.y + attachViewFrame.size.height * 0.5f;
                break;
            case SQBadgeViewAlignmentBottomLeft:
                center.x = attachViewFrame.origin.x;
                center.y = attachViewFrame.origin.y + attachViewFrame.size.height;
                break;
            case SQBadgeViewAlignmentBottomRight:
                center.x = attachViewFrame.origin.x + attachViewFrame.size.width;
                center.y = attachViewFrame.origin.y + attachViewFrame.size.height;
                break;
            case SQBadgeViewAlignmentBottomCenter:
                center.x = attachViewFrame.origin.x + attachViewFrame.size.width * 0.5f;
                center.y = attachViewFrame.origin.y + attachViewFrame.size.height;
                break;
            case SQBadgeViewAlignmentCenter:
                center.x = attachViewFrame.origin.x + attachViewFrame.size.width * 0.5f;
                center.y = attachViewFrame.origin.y + attachViewFrame.size.height * 0.5f;
                break;
            default:
                break;
        }
        
        center.x += _badgePositionAdjustment.x;
        center.y += _badgePositionAdjustment.y;
        
        self.bounds = CGRectIntegral(CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)));
        self.center = center;
        
    }else{
        
        CGRect  superviewBounds = self.superview.bounds;
        CGFloat superviewWidth  = superviewBounds.size.width;
        CGFloat superviewHeight = superviewBounds.size.height;
        
        switch (self.badgeViewAlignment) {
            case SQBadgeViewAlignmentTopLeft:
                frame.origin.x = -viewWidth * 0.5f;
                frame.origin.y = -viewHeight * 0.5f;
                break;
            case SQBadgeViewAlignmentTopRight:
                frame.origin.x = superviewWidth - (viewWidth * 0.5f);
                frame.origin.y = -viewHeight * 0.5f;
                break;
            case SQBadgeViewAlignmentTopCenter:
                frame.origin.x = (superviewWidth - viewWidth) * 0.5f;
                frame.origin.y = -viewHeight * 0.5f;
                break;
            case SQBadgeViewAlignmentCenterLeft:
                frame.origin.x = -viewWidth * 0.5f;
                frame.origin.y = (superviewHeight - viewHeight) * 0.5f;
                break;
            case SQBadgeViewAlignmentCenterRight:
                frame.origin.x = superviewWidth - (viewWidth * 0.5f);
                frame.origin.y = (superviewHeight - viewHeight) * 0.5f;
                break;
            case SQBadgeViewAlignmentBottomLeft:
                frame.origin.x = -viewWidth * 0.5f;
                frame.origin.y = superviewHeight - (viewHeight * 0.5f);
                break;
            case SQBadgeViewAlignmentBottomRight:
                frame.origin.x = superviewWidth - (viewWidth * 0.5f);
                frame.origin.y = superviewHeight - (viewHeight * 0.5f);
                break;
            case SQBadgeViewAlignmentBottomCenter:
                frame.origin.x = (superviewWidth - viewWidth) * 0.5f;
                frame.origin.y = superviewHeight - (viewHeight * 0.5f);
                break;
            case SQBadgeViewAlignmentCenter:
                frame.origin.x = (superviewWidth - viewWidth) * 0.5f;
                frame.origin.y = (superviewHeight - viewHeight) * 0.5f;
                break;
            default:
                break;
        }
        
        frame.origin.x += self.badgePositionAdjustment.x;
        frame.origin.y += self.badgePositionAdjustment.y;
        
        self.bounds = CGRectIntegral(CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)));
        self.center = CGPointMake(ceilf(CGRectGetMidX(frame)), ceilf(CGRectGetMidY(frame)));
    }
    
    self.originView.center = self.center;
    self.originView.layer.cornerRadius = self.originView.bounds.size.width * 0.5f;
    self.originView.bounds = CGRectMake(0, 0, self.badgeViewCornerRadius * (2 - 0.5f),
                                        self.badgeViewCornerRadius * (2 - 0.5f));
    [self setNeedsDisplay];
}

@end
