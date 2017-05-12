//
//  InterfaceTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYSpecialSaleViewOperation <NSObject>

- (void)pushToNextViewController;

@end

@protocol HYSpecialSaleModelInterface <NSObject>

@property (nonatomic,strong) NSArray * models;

@end

@protocol HYSpecialSaleViewModelInterface <NSObject>

@property (nonatomic,strong) id<HYSpecialSaleModelInterface> model;

- (void)initializeWithParameter:(NSDictionary *)parameter finishedCallBack:(void(^)())finishCallBack;

@end


@protocol HYSpecialSaleViewInterface <NSObject>

@property (nonatomic,strong) id<HYSpecialSaleViewModelInterface> hyspecialsaleViewModel;
@property (nonatomic,strong) id<HYSpecialSaleViewOperation> hyspecialsaleOperation;

@end

