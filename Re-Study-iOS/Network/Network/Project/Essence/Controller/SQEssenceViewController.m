//
//  EssenceViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQEssenceViewController.h"
#import "SQAllViewController.h"
#import "SQVideoViewController.h"
#import "SQVoiceViewController.h"
#import "SQPictureViewController.h"
#import "SQTextViewController.h"

@interface SQEssenceViewController ()
@end

@implementation SQEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
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

- (void)setupNavBar {
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highlightImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(leftBarButtonClick:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highlightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
}

- (void)leftBarButtonClick:(UIButton *)sender {
    NSLog(@"%s", __func__);
}

@end
