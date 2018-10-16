//
//  EssenceViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQEssenceViewController.h"
#import "ChildViewController/SQAllViewController.h"
#import "ChildViewController/SQVideoViewController.h"
#import "ChildViewController/SQVoiceViewController.h"
#import "ChildViewController/SQPictureViewController.h"
#import "ChildViewController/SQTextViewController.h"
#define Top ([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height)

@interface SQEssenceViewController ()

@end

@implementation SQEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setupButtonContainerView];
    [self setupTopTitleView];
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

- (void)setupButtonContainerView {
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:collectionView];
}

- (void)setupTopTitleView {
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Top, self.view.width, 35)];
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
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
