//
//  ViewTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSpecialSaleInterface.h"

@interface HYSpecialSaleView : UIView <HYSpecialSaleViewInterface>

@property (nonatomic,strong) id<HYSpecialSaleViewOperation> hyspecialsaleOperation;
@property (nonatomic,strong) id<HYSpecialSaleViewModelInterface> hyspecialsaleViewModel;

@end
