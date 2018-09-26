//
//  SQHomeDetailViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQHomeDetailViewController.h"
#import "UIImage+SQImage.h"
#import "SQCoverView.h"
#import "SQShareView.h"

@interface SQHomeDetailViewController () <SQCoverViewDelegate>
@property (nonatomic, weak) SQShareView * shareView;
@end

@implementation SQHomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HomeDetail";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Share" style:0 target:self action:@selector(shareBarButtonClick:)];
}

- (void)shareBarButtonClick:(UIBarButtonItem *)sender {
    SQCoverView * coverView = [SQCoverView show];
//    coverView.delegate = self;
    coverView.didClosedBlock = ^(SQCoverView * coverView){
        [self.shareView hiddenShareViewWhenCompletion:^{
            [coverView removeFromSuperview];
        }];
    };
    SQShareView * shareView = [SQShareView shareView];
    self.shareView = shareView;
}

- (void)coverViewDidClosed:(SQCoverView *)coverView {
    [self.shareView hiddenShareViewWhenCompletion:^{
        [coverView removeFromSuperview];
    }];
}

@end
