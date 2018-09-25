//
//  SQSaveTool.m
//  UI
//
//  Created by 朱双泉 on 2018/9/25.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSaveTool.h"

@implementation SQSaveTool

+ (void)setObject:(id)value forKey:(NSString *)defaultName {
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:defaultName];
}

+ (id)objectForKey:(NSString *)dafaultName {
    return [[NSUserDefaults standardUserDefaults]objectForKey:dafaultName];
}

@end
