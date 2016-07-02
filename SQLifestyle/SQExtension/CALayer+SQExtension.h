//
//  CALayer+SQExtension.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (SQExtension)

- (CALayer *)setShadowWithRadius:(CGFloat)radius offset:(CGSize)offset;

- (CAShapeLayer *)setLineDashWithPath:(UIBezierPath *)path lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor lineDashPattern:(NSArray *)lineDashPattern;

- (CATextLayer *)setTextWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;

- (CAGradientLayer *)setGradientWithColors:(NSArray *)colors/*(__bridge id)[UIColor redColor].CGColor*/ startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

- (CAReplicatorLayer *)addReplicatorWithSuperLayer:(CALayer *)layer coordinate:(CGPoint)coordinate;

@end
