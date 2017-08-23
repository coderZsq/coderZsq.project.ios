//
//  PresenterTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "SQPerfectPresenter.h"

@interface SQPerfectPresenter ()

@property (nonatomic,weak) id<SQPerfectViewInterface> perfectView;
@property (nonatomic,weak) id<SQPerfectViewModelInterface> perfectViewModel;

@end

@implementation SQPerfectPresenter

- (void)adapterWithPerfectView:(id<SQPerfectViewInterface>)perfectView perfectViewModel:(id<SQPerfectViewModelInterface>)perfectViewModel {

    _perfectView = perfectView;
    _perfectViewModel = perfectViewModel;

    __weak typeof(self) _self = self;
    __weak id<SQPerfectViewModelInterface> __perfectViewModel = _perfectViewModel;
    [_perfectViewModel initializeWithModel:__perfectViewModel.model kksss:_self.kksss tabId:_self.tabId completion:^{
        _self.perfectView.perfectViewModel = __perfectViewModel;
        _self.perfectView.perfectOperation = _self;
    }];
}

- (void)login1WithModel:(id<SQPerfectModelInterface>)model map:(NSDictionary *)map num:(NSInteger)num name:(NSString *)name completion:(void(^)())completion {

    __weak typeof(self) _self = self;
    __weak id<SQPerfectViewModelInterface> __perfectViewModel = _perfectViewModel;
    [_perfectViewModel login1WithModel:model map:map num:num name:name completion:^{
//        _self.perfectView.perfectViewModel = __perfectViewModel;
        completion();
    }];
}

- (void)login2WithModel:(id<SQPerfectModelInterface>)model map:(NSDictionary *)map completion:(void(^)())completion {

    __weak typeof(self) _self = self;
    __weak id<SQPerfectViewModelInterface> __perfectViewModel = _perfectViewModel;
    [_perfectViewModel login2WithModel:model map:map completion:^{
//        _self.perfectView.perfectViewModel = __perfectViewModel;
        completion();
    }];
}

- (void)login3WithModel:(id<SQPerfectModelInterface>)model num:(NSInteger)num completion:(void(^)())completion {

    __weak typeof(self) _self = self;
    __weak id<SQPerfectViewModelInterface> __perfectViewModel = _perfectViewModel;
    [_perfectViewModel login3WithModel:model num:num completion:^{
        _self.perfectView.perfectViewModel = __perfectViewModel;
        completion();
    }];
}

- (void)login4WithModel:(id<SQPerfectModelInterface>)model completion:(void(^)())completion {

    __weak typeof(self) _self = self;
    __weak id<SQPerfectViewModelInterface> __perfectViewModel = _perfectViewModel;
    [_perfectViewModel login4WithModel:model completion:^{
        _self.perfectView.perfectViewModel = __perfectViewModel;
        completion();
    }];
}



@end




