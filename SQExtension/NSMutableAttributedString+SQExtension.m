//
//  NSMutableAttributedString+SQExtension.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "NSMutableAttributedString+SQExtension.h"

@implementation NSMutableAttributedString (SQExtension)

- (NSMutableAttributedString *)addAttributeWithFontOfSize:(CGFloat)size color:(UIColor *)color name:(CFStringRef)name range:(NSRange)range {
    
    [self addAttributes:@{(id)kCTFontAttributeName : (__bridge id)CTFontCreateWithName(name, size, NULL),(id)NSForegroundColorAttributeName : color} range:range];
    return self;
}

- (NSMutableAttributedString *)addAttributeItalicWithFontOfSize:(CGFloat)size range:(NSRange)range {
    
    CTFontRef font = CTFontCreateWithName((CFStringRef)[UIFont italicSystemFontOfSize:size].fontName, size, NULL);
    [self addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:range];
    return self;
}

- (NSMutableAttributedString *)addAttributeUnderlineWithColor:(UIColor *)color range:(NSRange)range {
    
    [self addAttributes:@{(id)kCTUnderlineStyleAttributeName : (id)[NSNumber numberWithInt:kCTUnderlineStyleDouble],(id)NSUnderlineColorAttributeName : color} range:range];
    
    return self;
}

- (NSMutableAttributedString *)addAttributeStrikethroughWithColor:(UIColor *)color range:(NSRange)range {
    
    [self setAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid|NSUnderlineStyleSingle),   NSStrikethroughColorAttributeName : color} range:range];
    return self;
}

- (NSMutableAttributedString *)addAttributeSpace:(NSInteger)space range:(NSRange)range {
    
    CFNumberRef number = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&space);
    [self addAttribute:(id)kCTKernAttributeName value:(__bridge id)number range:range];
    return self;
}

- (NSMutableAttributedString *)addAttributeHollow:(NSInteger)hollow color:(UIColor *)color range:(NSRange)range{

    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&hollow);
    [self addAttributes:@{(id)kCTStrokeWidthAttributeName : (__bridge id)num , NSStrokeColorAttributeName : color} range:range];
    return self;
}

@end
