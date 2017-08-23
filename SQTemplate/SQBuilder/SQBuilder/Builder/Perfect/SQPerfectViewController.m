//
//  ControllerTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "SQPerfectViewController.h"
#import "SQPerfectPresenter.h"
#import "SQPerfectViewModel.h"
#import "SQPerfectView.h"

@interface SQPerfectViewController ()

@property (nonatomic,strong) SQPerfectPresenter * perfectPresenter;
@property (nonatomic,strong) SQPerfectViewModel * perfectViewModel;
@property (nonatomic,strong) SQPerfectView * perfectView;

@end

@implementation SQPerfectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self adapterView];
}

- (SQPerfectPresenter *)perfectPresenter {
    
    if (!_perfectPresenter) {
        _perfectPresenter = [SQPerfectPresenter new];
    }
    return _perfectPresenter;
}

- (SQPerfectViewModel *)perfectViewModel {
    
    if (!_perfectViewModel) {
        _perfectViewModel = [SQPerfectViewModel new];
    }
    return _perfectViewModel;
}

- (SQPerfectView *)perfectView {
    
    if (!_perfectView) {
        _perfectView = [SQPerfectView new];
        _perfectView.frame = self.view.bounds;
    }
    return _perfectView;
}

- (void)setupView {
    [self.view addSubview:self.perfectView];
}

- (void)adapterView {
    [self.perfectPresenter adapterWithPerfectView:self.perfectView perfectViewModel:self.perfectViewModel];
}

@end
