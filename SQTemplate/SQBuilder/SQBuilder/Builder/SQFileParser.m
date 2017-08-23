//
//  SQFileParser.m
//  SQBuilder
//
//  Created by 朱双泉 on 17/08/2017.
//  Copyright © 2017 Castie!. All rights reserved.
//

#import "SQFileParser.h"

@implementation SQFileParser

+ (NSDictionary *)parser_plist_r {
    
    NSBundle * bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"builder.bundle" ofType:nil]];
    NSDictionary * config = [NSDictionary dictionaryWithContentsOfFile:[bundle pathForResource:@"config/config.plist" ofType:nil]];
    NSMutableDictionary * plist = [NSDictionary dictionaryWithContentsOfFile:[bundle pathForResource:[NSString stringWithFormat:@"config/%@.plist",config[@"builderSource"]] ofType:nil]].mutableCopy;
    [config enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [plist setObject:obj forKey:key];
    }];
    return plist;
}

+ (void)parser_rw:(NSString *)path code:(NSString *)code filename:(NSString *)filename header:(NSString *)header parameter:(NSMutableArray *)parameter {

    NSString * arch = [[filename componentsSeparatedByString:@"."]firstObject];
    NSString * suffix = [[filename componentsSeparatedByString:@"."]lastObject];
    NSString * filename_r = [NSString stringWithFormat:@"%@Template.%@", arch,suffix];
    NSString * filename_w = [NSString stringWithFormat:@"%@/%@%@.%@", path,header,arch,suffix];
    NSString * template =  [SQFileParser parser_r:filename_r code:[code lowercaseString]];
    [[SQFileParser replaceThougth:template parameter:parameter] writeToFile:filename_w atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (NSString *)parser_r:(NSString *)filename code:(NSString *)code {
    
    NSBundle * bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"builder.bundle" ofType:nil]];
    return [NSMutableString stringWithContentsOfFile:[bundle pathForResource:[NSString stringWithFormat:@"template/%@/%@", code, filename] ofType:nil] encoding:NSUTF8StringEncoding error:nil];
}

static NSString * code;

+ (NSString *)replaceThougth:(NSString *)templete parameter:(NSMutableArray *)parameter {
    
    __block NSString * temp = templete;
    [[parameter firstObject] enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
        temp = [templete stringByReplacingOccurrencesOfString:key withString:obj];
    }];
    [parameter removeObjectAtIndex:0];
    if (parameter.count) {
        [SQFileParser replaceThougth:temp parameter:parameter];
    } else {
        code = temp;
    }
    return code;
}

@end
