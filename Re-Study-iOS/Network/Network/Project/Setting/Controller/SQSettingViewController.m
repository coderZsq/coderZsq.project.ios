//
//  SQSettingViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSettingViewController.h"
#import "SQBackView.h"

@interface SQSettingViewController ()

@end

@implementation SQSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[SQBackView backViewWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highlightImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(backButtonClick:) title:@"Back"]];
}

- (void)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
