//
//  SQFileParser.h
//  SQBuilder
//
//  Created by 朱双泉 on 17/08/2017.
//  Copyright © 2017 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQFileParser : NSObject

+ (NSDictionary *)parser_plist_r;

+ (void)parser_ios_rw:(NSString *)path filename:(NSString *)filename header:(NSString *)header parameter:(NSMutableArray *)parameter;

@end
