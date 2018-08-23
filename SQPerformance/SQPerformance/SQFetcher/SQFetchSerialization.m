//
//  SQFetchSerialization.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/8/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQFetchSerialization.h"
#import <UIKit/UIKit.h>

@implementation SQFetchSerialization

+ (NSString *)getMethodSerializationWithParameters:(NSDictionary *)parameters {
    
    NSMutableString * parameterString = [NSMutableString string];
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString * key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString * value = (NSString *)obj;
        [parameterString appendFormat:@"%@=%@&", key, value];
    }];
    if (parameterString.length) {
        [parameterString insertString:@"?" atIndex:0];
        [parameterString deleteCharactersInRange:NSMakeRange(parameterString.length - 1, 1)];
    }
    return parameterString;
}

+ (NSData *)postMethodSerializationWithParameters:(NSDictionary *)parameters {
    
    NSMutableString * parameterString = [NSMutableString string];
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString * key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString * value = (NSString *)obj;
        [parameterString appendFormat:@"%@=%@&", key, value];
    }];
    if (parameterString.length) {
        [parameterString deleteCharactersInRange:NSMakeRange(parameterString.length - 1, 1)];
    }
    return [parameterString dataUsingEncoding:NSUTF8StringEncoding];
}

+ (id)serializationWithContentType:(NSString *)contentType data:(NSData *)data error:(NSError *)error {
    
    id responseObject;
    if ([contentType isEqualToString:@"application/json"]) {
        responseObject = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers error:&error];
    } else if ([contentType isEqualToString:@"image/jpeg"]) {
        CGImageRef cgImage = [UIImage imageWithData:data].CGImage;
        CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(cgImage) & kCGBitmapAlphaInfoMask;
        
        BOOL hasAlpha = NO;
        if (alphaInfo == kCGImageAlphaPremultipliedLast ||
            alphaInfo == kCGImageAlphaPremultipliedFirst ||
            alphaInfo == kCGImageAlphaLast ||
            alphaInfo == kCGImageAlphaFirst) {
            hasAlpha = YES;
        }
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
        bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;
        
        size_t width = CGImageGetWidth(cgImage);
        size_t height = CGImageGetHeight(cgImage);
        
        CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, bitmapInfo);
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgImage);
        cgImage = CGBitmapContextCreateImage(context);
        
        UIImage * image = [UIImage imageWithCGImage:cgImage];
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
        CGImageRelease(cgImage);
        responseObject = image;
    }
    return responseObject;
}

@end
