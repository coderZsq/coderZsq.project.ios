//
//  Router.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/8.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "Router.h"
#import "CurrentViewController.h"

@interface Router ()

@property (nonatomic,strong) NSDictionary * map;

@end

@implementation Router

+ (instancetype)sharedInstance {
    
    static Router *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (NSDictionary *)map {
    
    if (!_map) {
        _map = @{@"Template" : @"ControllerTemplate",
                 @"SpecialSale" : @"HYSpecialSaleViewController"};
    }
    return _map;
}


- (void)addParamWithKey:(NSString *)key value:(id)value {
    _params[key] = value;
}

- (void)clearParams {
    [_params removeAllObjects];
}

- (void)push:(NSString *)path {
    Class cls = NSClassFromString(self.map[path]);
    [kCurrentViewController.navigationController pushViewController:[cls new] animated:YES];
}

@end
