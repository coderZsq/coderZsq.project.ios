//
//  UIView+SQExtension.h
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/12.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^SQWhenTappedBlock)(void);

@interface UIView (SQExtension)

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

NS_ASSUME_NONNULL_END
