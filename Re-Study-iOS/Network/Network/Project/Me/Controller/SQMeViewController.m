//
//  MeViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQMeViewController.h"

@interface SQMeViewController ()

@end

@implementation SQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Me";
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highlightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:nil action:nil], [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(moonBarButtonClick:)]];
}

- (void)moonBarButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
