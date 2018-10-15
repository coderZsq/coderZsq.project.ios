//
//  SQAdViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQAdViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "SQAdItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SQTabbarController.h"

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface SQAdViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) SQAdItem * item;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
@property (nonatomic, weak) NSTimer * timer;
@end

@implementation SQAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:@{@"code2" : code2} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        NSDictionary * ad = [responseObject[@"ad"] firstObject];
        SQAdItem * item = [SQAdItem mj_objectWithKeyValues:ad];
        UIImageView * imageView = [UIImageView new];
        imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, item.w ? [UIScreen mainScreen].bounds.size.width / item.w * item.h : 0);
        [imageView sd_setImageWithURL:[NSURL URLWithString:item.w_picurl]];
        [self.contentView addSubview:imageView];
        self.item = item;
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tapGesture];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    __weak typeof(self) _self = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1. repeats:YES block:^(NSTimer * _Nonnull timer) {
        static NSInteger count = 3;
        count--;
        [_self.skipButton setTitle:[NSString stringWithFormat:@"Skip(%li)", count] forState:UIControlStateNormal];
        if (count == -1) {
            [_self skipButtonClick:nil];
        }
    }];
}

- (void)tapGesture:(UITapGestureRecognizer *)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:_item.ori_curl]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_item.ori_curl] options:@{} completionHandler:nil];
    }
}

- (IBAction)skipButtonClick:(UIButton *)sender {
    [UIApplication sharedApplication].keyWindow.rootViewController = [SQTabBarController new];
    [self.timer invalidate];
    self.timer = nil;
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
