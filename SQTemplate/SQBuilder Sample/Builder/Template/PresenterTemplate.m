//
//  PresenterTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "<#Unit#>Presenter.h"

@implementation <#Unit#>Presenter

- (void)adapterWith<#Unit#>View:(id<<#Unit#>ViewInterface>)<#unit#>View <#unit#>ViewModel:(id<<#Unit#>ViewModelInterface>)<#unit#>ViewModel {

    _<#unit#>View = <#unit#>View;
    _<#unit#>ViewModel = <#unit#>ViewModel;
    [self dynamicBinding];
}

- (void)dynamicBinding {
    
    __weak typeof(self) _self = self;
    __weak id<<#Unit#>ViewModelInterface> __<#unit#>ViewModel = _<#unit#>ViewModel;
    [_<#unit#>ViewModel initializeWithParameter:nil finishedCallBack:^{
        _self.<#unit#>View.<#unit#>ViewModel = __<#unit#>ViewModel;
        _self.<#unit#>View.<#unit#>Operation = _self;
    }];
}

<#ViewOperation_m#>
@end




