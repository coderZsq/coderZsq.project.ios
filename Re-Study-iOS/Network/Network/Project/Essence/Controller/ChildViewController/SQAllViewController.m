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

@interface SQAllViewController ()
@property (nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation SQAllViewController

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[SQTopicCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(SQTopicItemTypeAll);
    [manager GET:BaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
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
