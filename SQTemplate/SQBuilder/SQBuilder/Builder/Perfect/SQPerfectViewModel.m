//
//  ViewModelTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "SQPerfectViewModel.h"
#import "SQPerfectModel.h"

@implementation SQPerfectViewModel

- (void)initializeWithModel:(id<SQPerfectModelInterface>)model kksss:(NSString *)kksss tabId:(NSInteger)tabId completion:(void(^)())completion {
    
    SQPerfectModel * model1 = [SQPerfectModel new];
    model1.name = @"name";
    self.model = model1;

    completion();
}

- (void)login1WithModel:(id<SQPerfectModelInterface>)model map:(NSDictionary *)map num:(NSInteger)num name:(NSString *)name completion:(void(^)())completion {
    self.model.name = @"name1";
    completion();
}

- (void)login2WithModel:(id<SQPerfectModelInterface>)model map:(NSDictionary *)map completion:(void(^)())completion {

}

- (void)login3WithModel:(id<SQPerfectModelInterface>)model num:(NSInteger)num completion:(void(^)())completion {

}

- (void)login4WithModel:(id<SQPerfectModelInterface>)model completion:(void(^)())completion {

}


@end
