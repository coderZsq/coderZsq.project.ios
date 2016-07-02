//
//  CAAnimation+SQExtension.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (SQExtension)

+ (CAAnimation *)animationShakeWithLayer:(CALayer *)layer xy:(NSString *)direction repeatCount:(CGFloat)count;

+ (CAAnimation *)animationRotateWithLayer:(CALayer *)layer repeatCount:(CGFloat)count;

/* type: pageCurl,pageUnCurl,rippleEffect,suckEffect,cube,oglFlip */
+ (CAAnimation *)animationTransitionWithLayer:(CALayer *)layer
                               transitionType:(NSString *)type
                            transitionSubtype:(NSString *)subtype;

+ (CAAnimation *)animationPopWithLayer:(CALayer *)layer;

@end
