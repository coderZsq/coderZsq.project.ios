//
//  ControllerTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYSpecialSaleViewController.h"
#import "HYSpecialSalePresenter.h"
#import "HYSpecialSaleViewModel.h"
#import "HYSpecialSaleView.h"

@interface HYSpecialSaleViewController ()

@property (nonatomic,strong) HYSpecialSalePresenter * hyspecialsalePresenter;
@property (nonatomic,strong) HYSpecialSaleViewModel * hyspecialsaleViewModel;
@property (nonatomic,strong) HYSpecialSaleView * hyspecialsaleView;

@end

@implementation HYSpecialSaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self adapterView];
}

- (HYSpecialSalePresenter *)hyspecialsalePresenter {
    
    if (!_hyspecialsalePresenter) {
        _hyspecialsalePresenter = [HYSpecialSalePresenter new];
    }
    return _hyspecialsalePresenter;
}

- (HYSpecialSaleViewModel *)hyspecialsaleViewModel {
    
    if (!_hyspecialsaleViewModel) {
        _hyspecialsaleViewModel = [HYSpecialSaleViewModel new];
    }
    return _hyspecialsaleViewModel;
}

- (HYSpecialSaleView *)hyspecialsaleView {
    
    if (!_hyspecialsaleView) {
        _hyspecialsaleView = [HYSpecialSaleView new];
        _hyspecialsaleView.frame = self.view.bounds;
    }
    return _hyspecialsaleView;
}

- (void)setupView {
    [self.view addSubview:self.hyspecialsaleView];
}

- (void)adapterView {
    [self.hyspecialsalePresenter adapterWithHYSpecialSaleView:self.hyspecialsaleView hyspecialsaleViewModel:self.hyspecialsaleViewModel];
}

@end
