//
//  SQWaterwaveView.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQWaterwaveView.h"

@interface SQWaterwaveView ()

@property (nonatomic,assign) CGFloat waterlevel;
@property (nonatomic,assign) CGFloat waterwave;
@property (nonatomic,assign) CGFloat defaultPercentage;
@property (nonatomic,assign,getter = isRepeat) BOOL repeat;

@property (nonatomic,strong) CAShapeLayer * shapeLayer;

@end

@implementation SQWaterwaveView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDisplayLink];
    }
    return self;
}

+(Class)layerClass {
    return [CAShapeLayer class];
}

- (void)setupDisplayLink {
    [[CADisplayLink displayLinkWithTarget:self selector:@selector(waterwaveAnimation)] addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (CGFloat)defaultPercentage {
    
    if (!_defaultPercentage) {
        _defaultPercentage = self.waterwavePercentage * 0.5f;
    }
    return _defaultPercentage;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setBackgroundColor:[UIColor clearColor]];
    
    self.shapeLayer = ({
        CAShapeLayer * shapeLayer = (CAShapeLayer *)self.layer;
        shapeLayer.lineWidth      = 1.0f;
        shapeLayer.bounds         = CGRectMake(0, 0, frame.size.width, frame.size.height);
        shapeLayer.fillMode       = kCAFillModeForwards;
        shapeLayer;
    });
    
    CAShapeLayer * maskLayer  = [CAShapeLayer layer];
    maskLayer.path            = [UIBezierPath bezierPathWithOvalInRect:self.shapeLayer.bounds].CGPath;
    self.shapeLayer.mask      = maskLayer ;
}

- (void)setWaterlevelPercentage:(CGFloat)waterlevelPercentage {
    _waterlevelPercentage = waterlevelPercentage;
    self.waterlevel = self.frame.size.height * (1.0f - waterlevelPercentage);
}

- (void)setWaterwavePercentage:(CGFloat)waterwavePercentage {
    _waterwavePercentage = waterwavePercentage * 10.0f;
}

- (void)waterwaveAnimation {
    
    self.isRepeat ? (self.defaultPercentage += 0.01f)
                  : (self.defaultPercentage -= 0.01f);
                    (self.waterwave += self.waterwaveAccelerate);
                    (self.shapeLayer.fillColor = self.waterwaveColor.CGColor);

    if (self.defaultPercentage <= 1)                        self.repeat = YES;
    if (self.defaultPercentage >= self.waterwavePercentage) self.repeat = NO;
    
    CGFloat waterlevel    = self.waterlevel;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, waterlevel);
    
    for(float i=0; i <= self.frame.size.width; i++){
        waterlevel= self.defaultPercentage * sin( i / 90 * M_PI + 4 * self.waterwave / M_PI ) * self.waterwavePercentage + self.waterlevel;
        CGPathAddLineToPoint(path, nil, i, waterlevel);
    }
    
    CGPathAddLineToPoint(path, nil, self.frame.size.width, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.waterlevel);
    
    [(CAShapeLayer *)self.layer setPath:path];
    
    CGPathRelease(path);
}

@end
