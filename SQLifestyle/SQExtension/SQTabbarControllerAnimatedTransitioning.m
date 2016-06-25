//
//  SQTabbarControllerAnimatedTransitioning.m
//
//  Created by Doubles_Z on 16-6-15.
//  Copyright (c) 2016年 Doubles_Z. All rights reserved.
//

#import "SQTabbarControllerAnimatedTransitioning.h"
#import "SQTabBarGlobal.h"

@implementation SQTabbarControllerAnimatedTransitioning

static CGFloat const kPadding  = 10;
static CGFloat const kDamping  = 0.75;
static CGFloat const kVelocity = 2;

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.75f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    
    CGFloat translation = containerView.bounds.size.width + kPadding;
    CGAffineTransform transform = CGAffineTransformMakeTranslation ((_preIndex > _selectedIndex ? YES : NO) ? translation : -translation, 0);
    toViewController.view.transform = CGAffineTransformInvert (transform);
    [containerView addSubview:toViewController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:kDamping initialSpringVelocity:kVelocity options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromViewController.view.transform = transform;
        toViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
