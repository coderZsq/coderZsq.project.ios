//
//  NewViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQNewViewController.h"
#import "SQSubTagViewController.h"
#import "SQAllViewController.h"
#import "SQVideoViewController.h"
#import "SQVoiceViewController.h"
#import "SQPictureViewController.h"
#import "SQTextViewController.h"

@interface SQNewViewController ()

@end

@implementation SQNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(subTagBarButtonClick:)];
    [self setupAllChildViewController];
}

- (void)setupAllChildViewController {
    SQAllViewController * allVc = [SQAllViewController new];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    SQVideoViewController * videoVc = [SQVideoViewController new];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    SQVoiceViewController * voiceVc = [SQVoiceViewController new];
    voiceVc.title = @"声音";
    [self addChildViewController:voiceVc];
    SQPictureViewController * pictureVc = [SQPictureViewController new];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    SQTextViewController * textVc = [SQTextViewController new];
    textVc.title = @"段子";
    [self addChildViewController:textVc];
}

- (void)subTagBarButtonClick:(UIButton *)sender {
    [self.navigationController pushViewController:[SQSubTagViewController new] animated:YES];
}

@end
