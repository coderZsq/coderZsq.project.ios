//
//  LayerController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "LayerController.h"
#define AngleToRadio(angle) ((angle) * M_PI / 180.)
#define kPerSecondArc 6
#define kPerMinuteArc 6
#define kPerHourArc 30
#define kPerMinHourArc .5

@interface LayerController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *clockImageView;
@property (nonatomic, weak) CALayer * layer;
@property (nonatomic, weak) CALayer * secondHandLayer;
@property (nonatomic, weak) CALayer * minuteHandLayer;
@property (nonatomic, weak) CALayer * hourHandLayer;
@property (nonatomic, weak) CALayer * fishLayer;
@end

@implementation LayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Layer";
    
    CALayer * layer = [CALayer layer];
    _layer = layer;
    //    layer.frame = CGRectMake(0, 0, 100, 100);
    layer.anchorPoint = CGPointMake(.5, .5);
    layer.position = CGPointMake(50, 50);
    layer.bounds = CGRectMake(0, 0, 100, 100);
    [self.contentView.layer addSublayer:layer];
    layer.borderColor = [SystemColor colorWithAlphaComponent:.5].CGColor;
    layer.borderWidth = 3;
    layer.shadowOpacity = 1.;
    layer.shadowOffset = CGSizeMake(3, 3);
    layer.shadowColor = [UIColor lightGrayColor].CGColor;
    layer.cornerRadius = 50;
    layer.masksToBounds = YES;
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"Avatar"].CGImage);
#if 0
    //        self.layerView.layer.transform = CATransform3DMakeRotation(M_PI, 1, 1, 0);
    self.layerView.layer.transform = CATransform3DRotate(self.layerView.layer.transform, M_PI, 1, 1, 0);
    //        self.layerView.layer.transform = CATransform3DMakeTranslation(50, 50, 1);
    self.layerView.layer.transform = CATransform3DTranslate(self.layerView.layer.transform, 50, 50, 0);
    //        self.layerView.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1);
    self.layerView.layer.transform = CATransform3DScale(self.layerView.layer.transform, 1.2, 1.2, 1);
#endif
    //        NSValue * value = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 0)];
    //        [self.layerView.layer setValue:value forKey:@"transform"];
    [layer setValue:@(M_PI) forKeyPath:@"transform.rotation.x"];
    [layer setValue:@(.95) forKeyPath:@"transform.scale"];
    NSLog(@"%@", NSStringFromCGPoint(self.contentView.center));
    NSLog(@"%@", NSStringFromCGPoint(self.contentView.layer.position));
    
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.toValue = @.8;
    animation.repeatCount = INFINITY;
    animation.duration = .25;
    animation.autoreverses = YES;
    [layer addAnimation:animation forKey:nil];
    
    CAKeyframeAnimation * keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath = @"transform.rotation";
    keyAnimation.values = @[@(AngleToRadio(-5)), @(AngleToRadio(5)), @(AngleToRadio(-5))];
    keyAnimation.repeatCount = INFINITY;
//    keyAnimation.autoreverses = YES;
    keyAnimation.duration = .25;
    [self.clockImageView.layer addAnimation:keyAnimation forKey:nil];
    
    [self clockRun];
    [NSTimer scheduledTimerWithTimeInterval:1. repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self clockRun];
    }];
    
    [self.contentView.layer addSublayer:self.fishLayer];
}

- (IBAction)transactionButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [CATransaction begin];
    CATransaction.disableActions = NO;
    CATransaction.animationDuration = .5;
    self.layer.cornerRadius = sender.selected ? 0 : 50;
    self.layer.transform = CATransform3DRotate(self.layer.transform, M_PI, 0, 0, 1);
    [CATransaction commit];
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    UIBezierPath * path = nil;
    if (!sender.selected) {
        [self.fishLayer removeAnimationForKey:@"rect"];
        path = [UIBezierPath bezierPathWithOvalInRect:self.contentView.bounds];
    } else {
        [self.fishLayer removeAnimationForKey:@"circle"];
        path = [UIBezierPath bezierPathWithRect:self.contentView.bounds];
    }
    animation.path = path.CGPath;
    animation.duration = 2.5;
    animation.repeatCount = INFINITY;
    animation.rotationMode = @"autoReverse";
    animation.calculationMode = @"paced";
    [self.fishLayer addAnimation:animation forKey: !sender.isSelected ? @"circle" : @"rect"];
}

- (CALayer *)secondHandLayer {
    
    if (!_secondHandLayer) {
        CALayer * layer = [CALayer layer];
        layer.backgroundColor = [UIColor redColor].CGColor;
        layer.bounds = CGRectMake(0, 0, 1, 35);
        layer.anchorPoint = CGPointMake(.5, 1);
        layer.position = CGPointMake(self.clockImageView.bounds.size.width * .5, self.clockImageView.bounds.size.height * .5);
        [self.clockImageView.layer addSublayer:layer];
        _secondHandLayer = layer;
    }
    return _secondHandLayer;
}

- (CALayer *)minuteHandLayer {
    
    if (!_minuteHandLayer) {
        CALayer * layer = [CALayer layer];
        layer.backgroundColor = [UIColor blackColor].CGColor;
        layer.bounds = CGRectMake(0, 0, 1.5, 35);
        layer.anchorPoint = CGPointMake(.5, 1);
        layer.position = CGPointMake(self.clockImageView.bounds.size.width * .5, self.clockImageView.bounds.size.height * .5);
        [self.clockImageView.layer addSublayer:layer];
        _minuteHandLayer = layer;
    }
    return _minuteHandLayer;
}

- (CALayer *)hourHandLayer {
    
    if (!_hourHandLayer) {
        CALayer * layer = [CALayer layer];
        layer.backgroundColor = [UIColor blackColor].CGColor;
        layer.bounds = CGRectMake(0, 0, 1.5, 25);
        layer.anchorPoint = CGPointMake(.5, 1);
        layer.position = CGPointMake(self.clockImageView.bounds.size.width * .5, self.clockImageView.bounds.size.height * .5);
        [self.clockImageView.layer addSublayer:layer];
        _hourHandLayer = layer;
    }
    return _hourHandLayer;
}

- (void)clockRun {
    NSCalendar * calender = [NSCalendar currentCalendar];
    NSDateComponents * cpt = [calender components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    NSInteger currentSecond = cpt.second;
    NSInteger currentMinute = cpt.minute;
    NSInteger currentHour = cpt.hour;
    CGFloat secondAngle = currentSecond * kPerSecondArc;
    CGFloat mintueAngle = currentMinute * kPerMinuteArc;
    CGFloat hourAngle = currentHour * kPerHourArc + currentMinute * kPerMinHourArc;
    self.minuteHandLayer.transform = CATransform3DMakeRotation(AngleToRadio(mintueAngle), 0, 0, 1);
    self.hourHandLayer.transform = CATransform3DMakeRotation(AngleToRadio(hourAngle), 0, 0, 1);
    self.secondHandLayer.transform = CATransform3DMakeRotation(AngleToRadio(secondAngle), 0, 0, 1);
}

- (CALayer *)fishLayer {
    
    if (!_fishLayer) {
        CALayer * layer = [CALayer layer];
        layer.frame = CGRectMake(50, 5, 60, 28);
        NSMutableArray * imageArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 10 ; i++) {
            UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"fish%ld", i]];
            [imageArray addObject:image];
        }
        __block NSInteger imageIndex = 0;
        [NSTimer scheduledTimerWithTimeInterval:.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            UIImage * image = imageArray[imageIndex];
            layer.contents = (__bridge id _Nullable)(image.CGImage);
            imageIndex++;
            if (imageIndex > 9) {
                imageIndex = 0;
            }
        }];
        CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"position";
        //        UIBezierPath * path = [UIBezierPath bezierPath];
        //        [path moveToPoint:CGPointMake(80, 5)];
        //        [path addLineToPoint:CGPointMake(25, 5)];
        //        [path addLineToPoint:CGPointMake(25, 80)];
        //        [path addQuadCurveToPoint:CGPointMake(60, 80) controlPoint:CGPointMake(100, 100)];
        //        [path addLineToPoint:CGPointMake(80, 5)];
        UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:self.contentView.bounds];
        animation.path = path.CGPath;
        animation.duration = 2.5;
        animation.repeatCount = INFINITY;
        animation.rotationMode = @"autoReverse";
        animation.calculationMode = @"paced";//@"cubie";
        [layer addAnimation:animation forKey:@"circle"];
        _fishLayer = layer;
    }
    return _fishLayer;
}

@end
