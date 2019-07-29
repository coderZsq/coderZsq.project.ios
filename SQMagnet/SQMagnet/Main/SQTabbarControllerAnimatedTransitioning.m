//
//  SQTabbarControllerAnimatedTransitioning.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/12.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTabbarControllerAnimatedTransitioning.h"

static CGFloat const kPadding  = 10;
static CGFloat const kDamping  = 0.75;
static CGFloat const kVelocity = 2;

@implementation SQTabbarControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return kDamping;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    CGFloat translation = containerView.bounds.size.width + kPadding;
    CGAffineTransform transform = CGAffineTransformMakeTranslation ((self.fromVCIndex > self.toVCIndex ? YES : NO) ? translation : -translation, 0);
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
