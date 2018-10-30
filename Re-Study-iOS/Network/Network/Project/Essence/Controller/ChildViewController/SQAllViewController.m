//
//  SQAllViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQAllViewController.h"
#import "SQTopicCell.h"
#import "SQTopicItem.h"
#import "SQTopicViewModel.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+Date.h"
#import "SQSeeBigPictureViewController.h"
#import "SQFootRefreshView.h"
#import "SQHeadRefreshView.h"
#import <MJRefresh.h>

@interface SQAllViewController ()
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, weak) SQFootRefreshView * footView;
@property (nonatomic, weak) SQHeadRefreshView * headView;
@property (nonatomic, copy) NSString * maxtime;
@property (nonatomic, assign) UIEdgeInsets originalInset;
@property (nonatomic, weak) AFHTTPSessionManager * manager;
@end

@implementation SQAllViewController

- (AFHTTPSessionManager *)manager {
    
    if (!_manager) {
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        _manager = manager;
    }
    return _manager;
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setBackgroundColor:[UIColor colorWithWhite:.95 alpha:1.]];
    [self.tableView registerClass:[SQTopicCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self loadNewData];
//    [self setupFootRefreshView];
//    [self setupHeadRefreshView];
    [self setupRefreshView];
    self.originalInset = self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(35, 0, _footView.height, 0);
}

- (void)setupRefreshView {
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = header;
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.automaticallyHidden = YES;
    self.tableView.mj_footer = footer;
}

- (void)setupHeadRefreshView {
    SQHeadRefreshView * headView = [SQHeadRefreshView headView];
    headView.y = -headView.height;
    _headView = headView;
    [self.tableView addSubview:headView];
}

- (void)setupFootRefreshView {
    SQFootRefreshView * footView = [SQFootRefreshView footView];
    footView.hidden = YES;
    _footView = footView;
    self.tableView.tableFooterView = footView;
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (self.headView.isNeedLoad) {
//        self.headView.isRefreshing = YES;
//        [UIView animateWithDuration:.25 animations:^{
//            self.tableView.contentInset = UIEdgeInsetsMake(self.originalInset.top + self.headView.height, 0, self.originalInset.bottom, 0);
//        }];
//        [self loadNewData];
//        self.headView.isNeedLoad = NO;
//    }
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [self dealFootRefreshView];
//    [self dealHeadRefreshView];
//}

- (void)dealHeadRefreshView {
    CGFloat offsetY = self.tableView.contentOffset.y;
    if (offsetY <= -(self.tableView.contentInset.top + _headView.height)) {
        _headView.isNeedLoad = YES;
    } else {
        _headView.isNeedLoad = NO;
    }
}

- (void)dealFootRefreshView {
    if (self.dataSource.count == 0) return;
    if (_footView.isRefreshing) return;
    CGFloat offsetY = self.tableView.contentOffset.y;
    if (offsetY >= self.tableView.contentSize.height + self.tableView.contentInset.bottom - [UIScreen mainScreen].bounds.size.height) {
        _footView.isRefreshing = YES;
        [self loadMoreData];
    }
}

- (void)loadMoreData {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(SQTopicItemTypeAll);
    parameters[@"maxtime"] = self.maxtime;
    [self.manager GET:BaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_footer endRefreshing];
        self.footView.isRefreshing = NO;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray * topics = [SQTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        for (SQTopicItem * item in topics) {
            SQTopicViewModel * vm = [SQTopicViewModel new];
            vm.item = item;
            [self.dataSource addObject:vm];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)loadNewData {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(SQTopicItemTypeAll);
    [self.manager GET:BaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        [self.tableView.mj_header endRefreshing];
//        [UIView animateWithDuration:.25 animations:^{
//            self.tableView.contentInset = self.originalInset;
//        }];
//        self.headView.isRefreshing = NO;
//        self.footView.hidden = YES;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray * topics = [SQTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        NSMutableArray * tempArr = @[].mutableCopy;
        for (SQTopicItem * item in topics) {
            SQTopicViewModel * vm = [SQTopicViewModel new];
            vm.item = item;
            [tempArr addObject:vm];
        }
        self.dataSource = tempArr;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQTopicViewModel *vm = self.dataSource[indexPath.row];
    SQTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    cell.topView.frame = vm.topViewFrame;
    [cell.topView.iconImageView sd_setImageWithURL:[NSURL URLWithString:vm.item.profile_image]];
    cell.topView.nameLabel.text = vm.item.screen_name;
    
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * createDate = [formatter dateFromString:vm.item.create_time];
    NSDateComponents * detalComponent = [createDate detalWithNow];
    NSString * time = vm.item.create_time;
    if ([createDate isThisYear]) {
        if ([createDate isThisToday]) {
            if (detalComponent.hour >= 1) {
                time = [NSString stringWithFormat:@"%ld小时前", detalComponent.hour];
            } else if (detalComponent.minute >= 1) {
                time = [NSString stringWithFormat:@"%ld分钟前", detalComponent.minute];
            } else {
                time = @"刚刚";
            }
        } else if ([createDate isThisYesterday]) {
            formatter.dateFormat = @"昨天 HH:mm";
            time = [formatter stringFromDate:createDate];
        } else {
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            time = [formatter stringFromDate:createDate];
        }
    }
    cell.topView.timeLabel.text = time;
    cell.topView.textLabel.text = vm.item.text;
    if (vm.item.type == SQTopicItemTypePicture) {
        cell.pictureView.frame = vm.middleViewFrame;
        cell.pictureView.imageTouchBegin = ^{
            SQSeeBigPictureViewController * vc = [SQSeeBigPictureViewController new];
            vc.image0 = vm.item.image0;
            vc.width = vm.item.width;
            vc.height = vm.item.height;
            vc.is_bigPicture = vm.item.is_bigPicture;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
        };
        cell.videoView.hidden = YES;
        cell.pictureView.hidden = NO;
        cell.voiceView.hidden = YES;
        cell.pictureView.progressView.progress = 0;
        cell.pictureView.progressView.progressLabel.text = @"0.0%";
        __weak typeof(cell) _cell = cell;
        [cell.pictureView.pictureImageView sd_setImageWithURL:[NSURL URLWithString:vm.item.image0] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            if (expectedSize == -1) return;
            CGFloat progress = 1. * receivedSize / expectedSize;
            dispatch_async(dispatch_get_main_queue(), ^{
                _cell.pictureView.progressView.progressLabel.text = [NSString stringWithFormat:@"%.1f", progress];
                [_cell.pictureView.progressView setProgress:progress animated:YES];
            });
        } completed:nil];
        [cell.pictureView.gifImageView setHidden:!vm.item.is_gif];
        [cell.pictureView.seeBigButton setHidden:!vm.item.is_bigPicture];
        
        if (vm.item.is_bigPicture) {
            cell.pictureView.pictureImageView.contentMode = UIViewContentModeTop;
            cell.pictureView.pictureImageView.clipsToBounds = YES;
        } else {
            cell.pictureView.pictureImageView.contentMode = UIViewContentModeScaleToFill;
            cell.pictureView.pictureImageView.clipsToBounds = NO;
        }
    } else if (vm.item.type == SQTopicItemTypeVideo) {
        cell.videoView.frame = vm.middleViewFrame;
        cell.videoView.hidden = NO;
        cell.pictureView.hidden = YES;
        cell.voiceView.hidden = YES;
        [cell.videoView.pictureImageView sd_setImageWithURL:[NSURL URLWithString:vm.item.image0]];
        cell.videoView.playCountLabel.text = [NSString stringWithFormat:@"%@播放", vm.item.playcount];
        NSInteger second = vm.item.videotime % 60;
        NSInteger minute = vm.item.videotime / 60;
        cell.videoView.timeLabel.text = [NSString stringWithFormat:@"%02li:%02li", minute, second];
    } else if (vm.item.type == SQTopicItemTypeVoice) {
        cell.voiceView.frame = vm.middleViewFrame;
        cell.videoView.hidden = YES;
        cell.pictureView.hidden = YES;
        cell.voiceView.hidden = NO;
        [cell.voiceView.pictureImageView sd_setImageWithURL:[NSURL URLWithString:vm.item.image0]];
        cell.voiceView.playCountLabel.text = [NSString stringWithFormat:@"%@播放", vm.item.playcount];
        NSInteger second = vm.item.voicetime % 60;
        NSInteger minute = vm.item.voicetime / 60;
        cell.voiceView.timeLabel.text = [NSString stringWithFormat:@"%02li:%02li", minute, second];
    } else {
        cell.videoView.hidden = YES;
        cell.pictureView.hidden = YES;
        cell.voiceView.hidden = YES;
    }
    if (vm.item.topComment) {
        cell.commentView.hidden = NO;
        cell.commentView.frame = vm.commentViewFrame;
        if (vm.item.topComment.content.length) {
            cell.commentView.voiceView.hidden = YES;
            cell.commentView.totalLabel.hidden = NO;
            cell.commentView.totalLabel.text = vm.item.topComment.totalContent;
        } else {
            cell.commentView.voiceView.hidden = NO;
            cell.commentView.totalLabel.hidden = YES;
            cell.commentView.nameLabel.text = vm.item.topComment.user.username;
            [cell.commentView.voiceButton setTitle:vm.item.topComment.voicetime forState:UIControlStateNormal];
        }
    } else {
        cell.commentView.hidden = YES;
    }
    cell.bottomView.frame = vm.bottomViewFrame;
    [self setupButton:cell.bottomView.dingButton count:vm.item.ding title:@"赞"];
    [self setupButton:cell.bottomView.caiButton count:vm.item.cai title:@"踩"];
    [self setupButton:cell.bottomView.shareButton count:vm.item.repost title:@"分享"];
    [self setupButton:cell.bottomView.commentButton count:vm.item.comment title:@"评论"];
    return cell;
}

- (void)setupButton:(UIButton *)button count:(CGFloat)count title:(NSString *)title {
    NSString * str = title;
    if (count > 10000) {
        count /= 10000;
        str = [NSString stringWithFormat:@"%.1f万", count];
    } else if (count > 0) {
        str = [NSString stringWithFormat:@"%.0f", count];
    }
    str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
    [button setTitle:str forState:UIControlStateNormal];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQTopicViewModel * vm = self.dataSource[indexPath.row];
    return vm.cellH;
}

@end
