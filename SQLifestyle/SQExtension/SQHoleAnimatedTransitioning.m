//
//  SQHoleAnimatedTransitioning.m
//
//  Created by Doubles_Z on 16/7/1.
//  Copyright (c) 2016年 Doubles_Z. All rights reserved.
//

#import "SQHoleAnimatedTransitioning.h"

@interface SQHoleAnimatedTransitioning ()

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end

static const CGFloat kRatio = 1.5f;

@implementation SQHoleAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * containView = transitionContext.containerView;
    [containView addSubview:toViewController.view];
    [containView addSubview:fromViewController.view];
    
    UIView * endView = [UIView new];
    endView.frame = self.frame;
    UIBezierPath * endPath = [UIBezierPath bezierPathWithOvalInRect:endView.frame];
    
    UIView * startView = [UIView new];
    startView.center = endView.center;
    startView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height * kRatio, [UIScreen mainScreen].bounds.size.height * kRatio);
    UIBezierPath * startpath = [UIBezierPath bezierPathWithOvalInRect:startView.frame];
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    fromViewController.view.layer.mask = maskLayer;
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id )(startpath.CGPath);
    animation.toValue = (__bridge id )(endPath.CGPath);
    animation.duration = [self transitionDuration:self.transitionContext];
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    self.transitionContext = nil;
}


@end
