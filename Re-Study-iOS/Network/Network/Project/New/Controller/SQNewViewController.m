//
//  NewViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQNewViewController.h"
#import "SQSubTagViewController.h"

@interface SQNewViewController ()

@end

@implementation SQNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(subTagBarButtonClick:)];
}

- (void)subTagBarButtonClick:(UIButton *)sender {
    [self.navigationController pushViewController:[SQSubTagViewController new] animated:YES];
}

@end
