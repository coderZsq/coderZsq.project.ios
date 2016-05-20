//
//  NSMutableAttributedString+SQExtension.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface NSMutableAttributedString (SQExtension)

- (NSMutableAttributedString *)addAttributeWithFontOfSize:(CGFloat)size color:(UIColor *)color name:(CFStringRef)name/*CFSTR("Georgia")*/ range:(NSRange)range;

- (NSMutableAttributedString *)addAttributeItalicWithFontOfSize:(CGFloat)size  range:(NSRange)range;

- (NSMutableAttributedString *)addAttributeUnderlineWithColor:(UIColor *)color range:(NSRange)range;

- (NSMutableAttributedString *)addAttributeStrikethroughWithColor:(UIColor *)color range:(NSRange)range;

- (NSMutableAttributedString *)addAttributeSpace:(NSInteger)space range:(NSRange)range;

- (NSMutableAttributedString *)addAttributeHollow:(NSInteger)hollow color:(UIColor *)color range:(NSRange)range;

@end
