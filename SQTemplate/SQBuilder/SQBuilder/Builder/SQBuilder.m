//
//  SQBuilder.m
//  SQBuilder
//
//  Created by 朱双泉 on 17/08/2017.
//  Copyright © 2017 Castie!. All rights reserved.
//

#import "SQBuilder.h"
#import "SQBuilder_iOS.h"
#import "SQBuilder_Android.h"

typedef NS_ENUM(NSUInteger, SQBuilderType) {
    SQBuilderTypeNone,
    SQBuilderTypeiOS,
    SQBuilderTypeAndroid,
};

@implementation SQBuilder

+ (void)runWithFileParser:(NSDictionary *)config success:(void (^)())success failure:(void (^)())failure {

    SQBuilderType builderType = SQBuilderTypeNone;
    if ([config[@"builderType"] caseInsensitiveCompare:@"iOS"] == NSOrderedSame) {
        builderType = SQBuilderTypeiOS; success();
    } else if ([config[@"builderType"] caseInsensitiveCompare:@"Android"] == NSOrderedSame) {
        builderType = SQBuilderTypeAndroid; success();
    } else {
        failure(); return;
    }
    
    SQBuilder * builder = [SQBuilder builderWithType:builderType];
    builder.user = [[NSHomeDirectory() componentsSeparatedByString:@"/"] objectAtIndex:2];
    builder.prefix = config[@"prefix"];
    builder.module = config[@"module"];
    builder.parameter = config[@"parameter"];
    builder.dataList = config[@"dataList"];
    builder.actionList = config[@"actionList"];
    [builder build];
}

- (void)build {
    NSLog(@"please enter the right builder type!");
}

+ (SQBuilder *)builderWithType:(SQBuilderType)builderType {

    switch (builderType) {
        case SQBuilderTypeiOS:
            return [SQBuilder_iOS new];
            break;
        case SQBuilderTypeAndroid:
            return [SQBuilder_Android new];
            break;
        case SQBuilderTypeNone:
            return [SQBuilder new];
            break;
        default:
            break;
    }
}

@end
