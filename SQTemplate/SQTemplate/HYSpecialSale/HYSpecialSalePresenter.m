//
//  PresenterTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYSpecialSalePresenter.h"

@implementation HYSpecialSalePresenter

- (void)adapterWithHYSpecialSaleView:(id<HYSpecialSaleViewInterface>)hyspecialsaleView hyspecialsaleViewModel:(id<HYSpecialSaleViewModelInterface>)hyspecialsaleViewModel {

    _hyspecialsaleView = hyspecialsaleView;
    _hyspecialsaleViewModel = hyspecialsaleViewModel;
    [self dynamicBinding];
}

- (void)dynamicBinding {
    
    __weak typeof(self) _self = self;
    __weak id<HYSpecialSaleViewModelInterface> __hyspecialsaleViewModel = _hyspecialsaleViewModel;
    [_hyspecialsaleViewModel initializeWithParameter:nil finishedCallBack:^{
        _self.hyspecialsaleView.hyspecialsaleViewModel = __hyspecialsaleViewModel;
        _self.hyspecialsaleView.hyspecialsaleOperation = _self;
    }];
}

- (void)pushToNextViewController {

}


@end




