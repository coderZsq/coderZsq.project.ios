//
//  UIViewController+hook.m
//  SQTemplate
//
//  Created by 朱双泉 on 23/11/2017.
//  Copyright © 2017 Doubles_Z. All rights reserved.
//

#import "UIViewController+hook.h"
#import "CurrentViewController.h"
#import <Aspects.h>

@implementation UIViewController (hook)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
            kCurrentViewController = aspectInfo.instance;
        } error:NULL];
    });
}
    
@end
