//
//  NSDictionary+Unicode.m
//  TestExample
//
//  Created by Apple on 2019/1/25.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "NSDictionary+Unicode.h"
#import "NSObject+SafeSwizzle.h"
#import "NSString+Unicode.h"

@implementation NSDictionary (Unicode)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self exchangeInstance:[self class] selector:@selector(description) withSwizzledSelector:@selector(chinese_description)];
        [self exchangeInstance:[self class] selector:@selector(descriptionWithLocale:) withSwizzledSelector:@selector(chinese_descriptionWithLocale:)];
        [self exchangeInstance:[self class] selector:@selector(descriptionWithLocale:indent:) withSwizzledSelector:@selector(chinese_descriptionWithLocale:indent:)];
    });
}

- (NSString *)chinese_description{
    return [[self chinese_description] stringByReplaceUnicode];
}

- (NSString *)chinese_descriptionWithLocale:(nullable id)locale{
    return [[self chinese_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)chinese_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level{
    return [[self chinese_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end
