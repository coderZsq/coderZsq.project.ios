//
//  ControllerTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/5.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "<#Root#><#Unit#>ViewController.h"
#import "<#Root#><#Unit#>Presenter.h"
#import "<#Root#><#Unit#>ViewModel.h"
#import "<#Root#><#Unit#>View.h"

@interface <#Root#><#Unit#>ViewController ()

@property (nonatomic,strong) <#Root#><#Unit#>Presenter * <#unit#>Presenter;
@property (nonatomic,strong) <#Root#><#Unit#>ViewModel * <#unit#>ViewModel;
@property (nonatomic,strong) <#Root#><#Unit#>View * <#unit#>View;

@end

@implementation <#Root#><#Unit#>ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self adapterView];
}

- (<#Root#><#Unit#>Presenter *)<#unit#>Presenter {
    
    if (!_<#unit#>Presenter) {
        _<#unit#>Presenter = [<#Root#><#Unit#>Presenter new];<#InitializeAssignment#>
    }
    return _<#unit#>Presenter;
}

- (<#Root#><#Unit#>ViewModel *)<#unit#>ViewModel {
    
    if (!_<#unit#>ViewModel) {
        _<#unit#>ViewModel = [<#Root#><#Unit#>ViewModel new];
    }
    return _<#unit#>ViewModel;
}

- (<#Root#><#Unit#>View *)<#unit#>View {
    
    if (!_<#unit#>View) {
        _<#unit#>View = [<#Root#><#Unit#>View new];
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
