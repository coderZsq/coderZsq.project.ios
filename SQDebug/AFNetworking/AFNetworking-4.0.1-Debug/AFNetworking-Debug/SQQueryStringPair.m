//
//  SQQueryStringPair.m
//  AFNetworking-Debug
//
//  Created by 朱双泉 on 2020/11/22.
//

#import "SQQueryStringPair.h"

@implementation SQQueryStringPair

NSString * SQPercentEscapedStringFromString(NSString *string) {
//    return string;
    static NSString * const kSQCharactersGeneralDelimitersToEncode = @":#[]@";
    static NSString * const kSQCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kSQCharactersGeneralDelimitersToEncode stringByAppendingString:kSQCharactersSubDelimitersToEncode]];
    NSString *encoded = [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];

    static NSUInteger const batchSize = 50;
    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;
    while (index < string.length) {
        NSUInteger length = MIN(string.length - index, batchSize);
        NSRange range = NSMakeRange(index, length);
        range = [string rangeOfComposedCharacterSequencesForRange:range];
        NSString *substring = [string substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];
        index += range.length;
    }
    return encoded;
}

- (instancetype)initWithField:(id)field value:(id)value {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.field = field;
    self.value = value;

    return self;
}

- (NSString *)URLEncodedStringValue {
    if (!self.value || [self.value isEqual:[NSNull null]]) {
        return SQPercentEscapedStringFromString([self.field description]);
    } else {
        return [NSString stringWithFormat:@"%@=%@", SQPercentEscapedStringFromString([self.field description]), SQPercentEscapedStringFromString([self.value description])];
    }
}

- (NSString *)description {
    return [self URLEncodedStringValue];
}

@end
