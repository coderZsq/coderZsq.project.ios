//
//  UIApplication+SQViperRouter.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "UIApplication+SQViperRouter.h"
#import "SQRouter.h"

@implementation UIApplication (SQViperRouter)

- (SQRouter *)SQ_router {
    return [SQRouter new];
}

@end

