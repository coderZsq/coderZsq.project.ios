//
//  PresenterTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "PresenterTemplate.h"
#import "Router.h"

@implementation PresenterTemplate

- (void)adapterWithView:(id<ViewInterface>)view viewModel:(id<ViewModelInterface>)viewModel {

    _view = view;
    _viewModel = viewModel;
    [self dynamicBinding];
}

- (void)dynamicBinding {
    
    __weak typeof(self) _self = self;
    __weak id<ViewModelInterface> __viewModel = _viewModel;
    [_viewModel dynamicBindingWithFinishedCallBack:^{
        _self.view.viewModel = __viewModel;
        _self.view.operation = _self;
    }];
}

- (void)pushTo {
    [[Router sharedInstance] push:@"SpecialSale"];
}

@end




