//
//  BadgeValueButton.m
//  UI
//
//  Created by 朱双泉 on 2018/9/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "BadgeValueButton.h"

@interface BadgeValueButton ()
@property (nonatomic, weak) IBOutlet UIButton * button;
@property (nonatomic, weak) CAShapeLayer * shapeLayer;
@end

@implementation BadgeValueButton

- (CAShapeLayer *)shapeLayer {
    
    if (!_shapeLayer) {
        CAShapeLayer * layer = [CAShapeLayer layer];
        layer.fillColor = self.backgroundColor.CGColor;
        [self.superview.layer insertSublayer:layer atIndex:0];
        _shapeLayer = layer;
    }
    return _shapeLayer;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.layer.cornerRadius = self.bounds.size.width * .5;
    [self setBackgroundColor:SystemColor];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestue:)];
    [self addGestureRecognizer:panGesture];
    self.button.layer.cornerRadius = self.layer.cornerRadius;
}

- (void)panGestue:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self];
    //    self.transform = CGAffineTransformTranslate(self.transform, translation.x, translation.y);
    CGPoint center = self.center;
    center.x += translation.x;
    center.y += translation.y;
    self.center = center;
    [sender setTranslation:CGPointZero inView:self];
    CGFloat distance = [self distanceWithView1:self.button view2:self];
    CGFloat radius = self.bounds.size.width * .5;
    radius = radius - distance / 10.;
    radius = radius <= 0 ? 0 : radius;
    self.button.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
    self.button.layer.cornerRadius = radius;
    if (self.button.hidden == NO) {
        UIBezierPath * path = [self bezierPathWithView1:self.button view2:self];
        self.shapeLayer.path = path.CGPath;
    }
    if (distance > 1000) {
        self.button.hidden = YES;
        [self.shapeLayer removeFromSuperlayer];
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (distance <= 1000) {
            [UIView animateWithDuration:.25 delay:0 usingSpringWithDamping:.1 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
                self.center = self.button.center;
            } completion:nil];
            self.button.hidden = NO;
            [self.shapeLayer removeFromSuperlayer];
        } else {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.bounds];
            NSMutableArray * arrayM = [NSMutableArray array];
            for (NSInteger i = 1; i <= 8; i++) {
                UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"0%ld", i]];
                [arrayM addObject:image];
            }
            imageView.animationImages = arrayM;
//            imageView.animationRepeatCount = 1;
            imageView.animationDuration = 1.;
            [imageView startAnimating];
            [self addSubview:imageView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
                [self.button removeFromSuperview];
            });
        }
    }
}

- (CGFloat)distanceWithView1:(UIView *)view1 view2:(UIView *)view2 {
    CGFloat offsetX = view1.center.x - view2.center.x;
    CGFloat offsetY = view1.center.y - view2.center.y;
    return sqrt(offsetX * offsetX + offsetY * offsetY);
}

- (UIBezierPath *)bezierPathWithView1:(UIView *)view1 view2:(UIView *)view2 {
    CGFloat x1 = view1.center.x;
    CGFloat y1 = view1.center.y;
    CGFloat x2 = view2.center.x;
    CGFloat y2 = view2.center.y;
    CGFloat d = [self distanceWithView1:view1 view2:view2];
    if (d <= 0) {
        return nil;
    }
    CGFloat cosθ = (y2 - y1) / d;
    CGFloat sinθ = (x2 - x1) / d;
    CGFloat r1 = view1.bounds.size.width * .5;
    CGFloat r2 = view2.bounds.size.width * .5;
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ, y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ, y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ, y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ, y2 + r2 * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + d * .5 * sinθ, pointA.y + d * .5 * cosθ);
    CGPoint pointP = CGPointMake(pointB.x + d * .5 * sinθ, pointB.y + d * .5 * cosθ);
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    [path addLineToPoint:pointD];
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    return path;
}

- (void)setHighlighted:(BOOL)highlighted {}

@end
