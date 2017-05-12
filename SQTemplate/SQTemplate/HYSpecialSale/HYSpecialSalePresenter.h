//
//  PresenterTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSpecialSaleInterface.h"

@interface HYSpecialSalePresenter : NSObject<HYSpecialSaleViewOperation>

@property (nonatomic,weak) id<HYSpecialSaleViewInterface> hyspecialsaleView;
@property (nonatomic,weak) id<HYSpecialSaleViewModelInterface> hyspecialsaleViewModel;

- (void)adapterWithHYSpecialSaleView:(id<HYSpecialSaleViewInterface>)hyspecialsaleView hyspecialsaleViewModel:(id<HYSpecialSaleViewModelInterface>)hyspecialsaleViewModel;

@end
