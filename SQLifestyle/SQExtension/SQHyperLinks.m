//
//  SQHyperLinks.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQHyperLinks.h"

@implementation SQHyperLinks

@synthesize hyperLinkColor          = _hyperLinkColor;
@synthesize hyperLinkHighlightColor = _hyperLinkHighlightColor;

- (UIColor *)hyperLinkColor {
    
    if (!_hyperLinkColor) {
        _hyperLinkColor = [UIColor blueColor];
        [self setTitleColor:_hyperLinkColor forState:UIControlStateNormal];
    }
    return _hyperLinkColor;
}

- (UIColor *)hyperLinkHighlightColor {
    
    if (!_hyperLinkHighlightColor) {
        _hyperLinkHighlightColor = [UIColor purpleColor];
    }
    return _hyperLinkHighlightColor;
}

- (void)setHyperLinkColor:(UIColor *)hyperLinkColor {
    _hyperLinkColor = hyperLinkColor;
    [self setTitleColor:self.hyperLinkColor forState:UIControlStateNormal];
}

- (void)setHyperLinkHighlightColor:(UIColor *)hyperLinkHighlightColor {
    _hyperLinkHighlightColor = hyperLinkHighlightColor;
    [self setTitleColor:self.hyperLinkHighlightColor forState:UIControlStateHighlighted];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self setTitleColor:self.hyperLinkHighlightColor forState:UIControlStateHighlighted];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.hyperLink]]];
}

- (void)drawRect:(CGRect)rect {
    
    CGRect textRect = self.titleLabel.frame;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGFloat descender = self.titleLabel.font.descender; //descender:字体设计 字符距离
    CGContextSetStrokeColorWithColor(contextRef, self.hyperLinkColor.CGColor);
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender + 2);
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender + 2);
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}

@end
