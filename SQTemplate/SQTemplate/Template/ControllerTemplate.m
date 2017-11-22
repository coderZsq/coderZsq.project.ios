//
//  ControllerTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "ControllerTemplate.h"
#import "PresenterTemplate.h"
#import "ViewModelTemplate.h"
#import "ViewTemplate.h"

@interface ControllerTemplate ()

@property (nonatomic,strong) PresenterTemplate * presenter;
@property (nonatomic,strong) ViewModelTemplate * viewModel;
@property (nonatomic,strong) ViewTemplate * baseView;

@end

@implementation ControllerTemplate

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self adapterView];
}

- (PresenterTemplate *)presenter {
    
    if (!_presenter) {
        _presenter = [PresenterTemplate new];
    }
    return _presenter;
}

- (ViewModelTemplate *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [ViewModelTemplate new];
    }
    return _viewModel;
}

- (ViewTemplate *)baseView {
    
    if (!_baseView) {
        _baseView = [ViewTemplate new];
        _baseView.frame = self.view.bounds;
    }
    return _baseView;
}

- (void)setupView {
    [self.view addSubview:self.baseView];
}

- (void)adapterView {
    [self.presenter adapterWithView:self.baseView viewModel:self.viewModel];
}

@end
