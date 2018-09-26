//
//  ContentView.m
//  UI
//
//  Created by 朱双泉 on 2018/9/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ContentView.h"

@interface ContentView ()
@property (nonatomic, strong) UIBezierPath * path;
@property (nonatomic, weak) CALayer * dotLayer;
@property (nonatomic, weak) CAShapeLayer * shapeLayer;
@end

@implementation ContentView

- (CAShapeLayer *)shapeLayer {
    
    if (!_shapeLayer) {
        CAShapeLayer * shapeLayer = [CAShapeLayer layer];
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [SystemColor colorWithAlphaComponent:.5].CGColor;
        shapeLayer.lineWidth = 5.;
        [self.layer addSublayer:shapeLayer];
        _shapeLayer = shapeLayer;
    }
    return _shapeLayer;
}

+ (Class)layerClass {
    return [CAReplicatorLayer class];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:panGesture];

    UIBezierPath * path = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"path" ofType:@"data"]];
    if (!path) path = [UIBezierPath bezierPath];
    path.lineWidth = 5.;
    self.path = path;
    
    CALayer * layer = [CALayer layer];
    layer.frame = CGRectMake(-20, 0, 20, 20);
    layer.cornerRadius = 10;
    layer.backgroundColor = [SystemColor colorWithAlphaComponent:.7].CGColor;
    [self.layer addSublayer:layer];
    self.dotLayer = layer;
    self.clipsToBounds = YES;
    
    CAReplicatorLayer * replicatorLayer = (CAReplicatorLayer *)self.layer;
    replicatorLayer.instanceCount = 6;
    replicatorLayer.instanceDelay = .8;
    
    self.shapeLayer.path = self.path.CGPath;
}

- (void)panGesture:(UIPanGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self];
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.path moveToPoint:location];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        [self.path addLineToPoint:location];
//        [self setNeedsDisplay];
        self.shapeLayer.path = self.path.CGPath;
    }
}

- (IBAction)startButtonClick:(UIButton *)sender {
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.path = self.path.CGPath;
    animation.repeatCount = INFINITY;
    animation.duration = 8.;
    [self.dotLayer addAnimation:animation forKey:nil];
}

- (IBAction)redrawButtonClick:(UIButton *)sender {
    [self.dotLayer removeAllAnimations];
    [self.path removeAllPoints];
//    [self setNeedsDisplay];
    self.shapeLayer.path = self.path.CGPath;
}

//- (void)drawRect:(CGRect)rect {
//    [[SystemColor colorWithAlphaComponent:.7] set];
//    [self.path stroke];
//}

@end
