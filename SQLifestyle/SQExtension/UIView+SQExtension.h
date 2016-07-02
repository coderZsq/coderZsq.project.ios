//
//  UIView+SQExtension.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SQWhenTappedBlock)();

@interface UIView (SQExtension)<UIGestureRecognizerDelegate>

- (CGFloat)xMax;

- (CGFloat)xMiddle;

- (CGFloat)x;

- (CGFloat)yMax;

- (CGFloat)yMiddle;

- (CGFloat)y;

- (CGFloat)width;

- (CGFloat)height;

- (void)removeAllSubviews;

- (void)whenTapped:(SQWhenTappedBlock)block;

- (void)whenDoubleTapped:(SQWhenTappedBlock)block;

- (void)whenTwoFingerTapped:(SQWhenTappedBlock)block;

- (void)whenTouchedDown:(SQWhenTappedBlock)block;

- (void)whenTouchedUp:(SQWhenTappedBlock)block;

- (void)loomingAnimationWithDuration:(CGFloat)duration;

@end
