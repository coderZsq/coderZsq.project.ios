//
//  CAAnimation+SQExtension.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "CAAnimation+SQExtension.h"

@implementation CAAnimation (SQExtension)

+ (CAAnimation *)animationShakeWithLayer:(CALayer *)layer xy:(NSString *)direction repeatCount:(CGFloat)count {
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath     = [NSString stringWithFormat:@"position.%@",direction ? direction : @"x"];
    animation.values      = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes    = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration    = 0.25f;
    animation.repeatCount = count ? count : 1;
    animation.additive    = YES;
    [layer addAnimation:animation forKey:@"shake"];
    return animation;
}

+ (CAAnimation *)animationRotateWithLayer:(CALayer *)layer repeatCount:(CGFloat)count {
    
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath        = @"transform.rotation.z";
    animation.toValue        = @(2 * M_PI);
    animation.duration       = 2.0f;
    animation.repeatCount    = count ? count : 1;
    [layer addAnimation:animation forKey:@"rotate"];
    return animation;
}

+ (CAAnimation *)animationTransitionWithLayer:(CALayer *)layer transitionType:(NSString *)type transitionSubtype:(NSString *)subtype {
    
    CATransition * animation = [CATransition animation];
    animation.type           = type;
    animation.subtype        = subtype;
    animation.duration       = 0.4f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    [layer addAnimation:animation forKey:@"transition"];
    return animation;
}

+ (CAAnimation *)animationPopWithLayer:(CALayer *)layer {
    
    CAKeyframeAnimation * pop = [CAKeyframeAnimation animation];
    pop.keyPath     = @"transform.scale";
    pop.values      = @[@0.1, @0.2, @0.3, @0.2, @0.1];
    pop.additive    = YES;
    
    CAAnimationGroup * group = [CAAnimationGroup new];
    group.animations = @[pop];
    group.duration = kTimeInterval;
    group.removedOnCompletion = NO;
    [layer addAnimation:group forKey:nil];
    return group;
}

@end
