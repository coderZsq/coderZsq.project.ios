//
//  PresenterTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "<#Root#><#Unit#>Presenter.h"

@interface <#Root#><#Unit#>Presenter ()

@property (nonatomic,weak) id<<#Root#><#Unit#>ViewInterface> <#unit#>View;
@property (nonatomic,weak) id<<#Root#><#Unit#>ViewModelInterface> <#unit#>ViewModel;

@end

@implementation <#Root#><#Unit#>Presenter

- (void)adapterWith<#Unit#>View:(id<<#Root#><#Unit#>ViewInterface>)<#unit#>View <#unit#>ViewModel:(id<<#Root#><#Unit#>ViewModelInterface>)<#unit#>ViewModel {

    _<#unit#>View = <#unit#>View;
    _<#unit#>ViewModel = <#unit#>ViewModel;

    __weak typeof(self) _self = self;
    __weak id<<#Root#><#Unit#>ViewModelInterface> __<#unit#>ViewModel = _<#unit#>ViewModel;
    [_<#unit#>ViewModel initializeWithModel:__<#unit#>ViewModel.model <#InitializeParameter#>completion:^{
        _self.<#unit#>View.<#unit#>ViewModel = __<#unit#>ViewModel;
        _self.<#unit#>View.<#unit#>Operator = _self;
    }];
}

<#ViewOperation_m#>

@end




