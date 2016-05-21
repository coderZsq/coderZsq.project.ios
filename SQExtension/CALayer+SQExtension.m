//
//  CALayer+SQExtension.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "CALayer+SQExtension.h"

@implementation CALayer (SQExtension)

- (CALayer *)setShadowWithRadius:(CGFloat)radius offset:(CGSize)offset {

    self.shadowOpacity = 0.5f;
    self.shadowRadius  = radius;
    self.shadowColor   = [UIColor blackColor].CGColor;
    self.shadowOffset  = offset;
    return self;
}

- (CAShapeLayer *)setLineDashWithPath:(UIBezierPath *)path lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor lineDashPattern:(NSArray *)lineDashPattern {
    
    CAShapeLayer * shapeLayer  = [CAShapeLayer layer];
    shapeLayer.path            = path.CGPath;
    shapeLayer.lineWidth       = lineWidth;
    shapeLayer.lineDashPattern = lineDashPattern;
    shapeLayer.strokeColor     = lineColor.CGColor;
    shapeLayer.fillColor       = [UIColor clearColor].CGColor;
    [self addSublayer:shapeLayer];
    return shapeLayer;
}

- (CATextLayer *)setTextWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font {

    CATextLayer * textLayer   = [CATextLayer layer];
    CFStringRef fontName      = (__bridge CFStringRef)font.fontName;
    CGFontRef fontref         = CGFontCreateWithFontName(fontName);
    textLayer.contentsScale   = [UIScreen mainScreen].scale;
    textLayer.frame           = self.bounds;
    textLayer.foregroundColor = textColor.CGColor;
    textLayer.alignmentMode   = kCAAlignmentLeft;
    textLayer.wrapped         = YES;
    textLayer.string          = text;
    textLayer.font            = fontref;
    textLayer.fontSize        = font.pointSize;
    CGFontRelease(fontref);
    [self addSublayer:textLayer];
    return textLayer;
}

- (CAGradientLayer *)setGradientWithColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {

    CAGradientLayer * gradientLayer = [CAGradientLayer layer]; /*gradientLayer.locations*/
    gradientLayer.frame             = self.bounds;
    gradientLayer.colors            = colors;
    gradientLayer.startPoint        = startPoint;
    gradientLayer.endPoint          = endPoint;
    [self addSublayer:gradientLayer];
    return gradientLayer;
}

- (CAReplicatorLayer *)addReplicatorWithSuperLayer:(CALayer *)layer coordinate:(CGPoint)coordinate {

    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.instanceCount       = 2;
    replicatorLayer.frame               = (CGRect){coordinate,{self.frame.size.width ,self.frame.size.height * replicatorLayer.instanceCount}};
    replicatorLayer.instanceTransform   = CATransform3DMakeScale(1, -1, 0);
    replicatorLayer.instanceAlphaOffset = -0.5f;
    [replicatorLayer addSublayer:self];
    [layer addSublayer:replicatorLayer];
    return replicatorLayer;
}

@end
