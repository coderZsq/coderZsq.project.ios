//
//  ControllerTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "<#Unit#>ViewController.h"
#import "<#Unit#>Presenter.h"
#import "<#Unit#>ViewModel.h"
#import "<#Unit#>View.h"

@interface <#Unit#>ViewController ()

@property (nonatomic,strong) <#Unit#>Presenter * <#unit#>Presenter;
@property (nonatomic,strong) <#Unit#>ViewModel * <#unit#>ViewModel;
@property (nonatomic,strong) <#Unit#>View * <#unit#>View;

@end

@implementation <#Unit#>ViewController

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self adapterView];
}

- (<#Unit#>Presenter *)<#unit#>Presenter {
    
    if (!_<#unit#>Presenter) {
        _<#unit#>Presenter = [<#Unit#>Presenter new];
    }
    return _<#unit#>Presenter;
}

- (<#Unit#>ViewModel *)<#unit#>ViewModel {
    
    if (!_<#unit#>ViewModel) {
        _<#unit#>ViewModel = [<#Unit#>ViewModel new];
    }
    return _<#unit#>ViewModel;
}

- (<#Unit#>View *)<#unit#>View {
    
    if (!_<#unit#>View) {
        _<#unit#>View = [<#Unit#>View new];
        _<#unit#>View.frame = self.view.bounds;
    }
    return _<#unit#>View;
}

- (void)setupView {
    [self.view addSubview:self.<#unit#>View];
}

- (void)adapterView {
    [self.<#unit#>Presenter adapterWith<#Unit#>View:self.<#unit#>View <#unit#>ViewModel:self.<#unit#>ViewModel];
}

@end
