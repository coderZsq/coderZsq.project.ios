//
//  SQSettingViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSettingViewController.h"
#import <SDImageCache.h>
#import "SQFileManager.h"
#import <SVProgressHUD.h>

#define CachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject

@interface SQSettingViewController ()

@end

@implementation SQSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Setting";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}
//
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
//    NSInteger cacheSize = [SDImageCache sharedImageCache].getSize;
    [SVProgressHUD showWithStatus:@"Calculate Cache..."];
    [SQFileManager directorySizeString:CachePath completion:^(NSString * _Nonnull sizeString) {
        [SVProgressHUD dismiss];
        cell.textLabel.text = sizeString;
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [SQFileManager removeDirectoryPath:CachePath completion:^{
        [self.tableView reloadData];
    }];
}

@end
