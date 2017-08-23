//
//  ViewModelTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQPerfectInterface.h"

@interface SQPerfectViewModel : NSObject <SQPerfectViewModelInterface>

@property (nonatomic,strong) id<SQPerfectModelInterface> model;

- (void)initializeWithModel:(id<SQPerfectModelInterface>)model kksss:(NSString *)kksss tabId:(NSInteger)tabId completion:(void(^)())completion;
- (void)login1WithModel:(id<SQPerfectModelInterface>)model map:(NSDictionary *)map num:(NSInteger)num name:(NSString *)name completion:(void(^)())completion;
- (void)login2WithModel:(id<SQPerfectModelInterface>)model map:(NSDictionary *)map completion:(void(^)())completion;
- (void)login3WithModel:(id<SQPerfectModelInterface>)model num:(NSInteger)num completion:(void(^)())completion;
- (void)login4WithModel:(id<SQPerfectModelInterface>)model completion:(void(^)())completion;


@end
