//
//  EssenceViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQEssenceViewController.h"

@interface SQEssenceViewController ()

@end

@implementation SQEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highlightImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(leftBarButtonClick:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highlightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
}

- (void)leftBarButtonClick:(UIButton *)sender {
    NSLog(@"%s", __func__);
}

@end
