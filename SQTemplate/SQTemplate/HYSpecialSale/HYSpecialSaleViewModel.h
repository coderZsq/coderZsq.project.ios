//
//  ViewModelTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYSpecialSaleInterface.h"

@interface HYSpecialSaleViewModel : NSObject <HYSpecialSaleViewModelInterface>

@property (nonatomic,strong) id<HYSpecialSaleModelInterface> model;

- (void)initializeWithParameter:(NSDictionary *)parameter finishedCallBack:(void(^)())finishCallBack;

@end
