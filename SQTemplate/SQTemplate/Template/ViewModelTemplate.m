//
//  ViewModelTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "ViewModelTemplate.h"
#import "ModelTemplate.h"
#import "NetWork.h"
#import "DataBase.h"

@implementation ViewModelTemplate

- (NSMutableArray *)models {
    
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

- (void)dynamicBindingWithFinishedCallBack:(void (^)())finishCallBack {

    [DataBase requestDataWithClass:[NSObject class] finishedCallBack:^(NSDictionary *response) {
        
        NSDictionary * data = response;
        NSArray * models = data[@"models"];
        
        [self.models removeAllObjects];
        for (NSDictionary * dict in models) {
            [self.models addObject:[ModelTemplate modelWithDictionary:dict]];
        }
        
        finishCallBack();
    }];
    
    [NetWork requestDataWithType:MethodGetType URLString:@"http://localhost:3001/api/J1/getJ1List" parameter:nil finishedCallBack:^(NSDictionary * response){
        
        NSDictionary * data = response[@"data"];
        NSArray * models = data[@"models"];
        
        [self.models removeAllObjects];
        for (NSDictionary * dict in models) {
            [self.models addObject:[ModelTemplate modelWithDictionary:dict]];
        }
        
        [DataBase cache:[NSObject class] data:data[@"models"]];
        finishCallBack();
    }];
}

@end
