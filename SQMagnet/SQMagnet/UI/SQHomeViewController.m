//
//  SQHomeViewController.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQHomeViewController.h"
#import "UIViewController+SQExtension.h"
#import "SQListViewController.h"
#import "SQH1TitleView.h"
#import "SQSearchInputView.h"
#import "SQType1Cell.h"
#import "SQType1Model.h"
#import "SQNetWorkTool.h"
#import <MJExtension/MJExtension.h>

@interface SQHomeViewController ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIColor *defaultColor;
@property (nonatomic, strong) NSMutableDictionary *datas;
@property (nonatomic, strong) NSArray *tags;

@end

@implementation SQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    self.titleLabel = [self findNavigationBarContentViewTitleLabel];
    self.defaultColor = self.titleLabel.textColor;
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = self.titleLabel.font;
    titleLabel.text = self.titleLabel.text;
    titleLabel.textColor = [UIColor clearColor];
    titleLabel.frame = self.titleLabel.frame;
    self.navigationItem.titleView = titleLabel;
    self.titleLabel = titleLabel;

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(SQType1Cell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(SQType1Cell.class)];
    
    self.tags = @[@"推荐", @"神作"];
    [self loadDataFromLocal];
//    [self loadDataFromRemote];
}

- (void)loadDataFromLocal {
    self.datas = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"SQHomeData" ofType:@"plist"]].mutableCopy;
    [self.datas enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSArray *results, BOOL * _Nonnull stop) {
        self.datas[key] = [SQType1Model mj_objectArrayWithKeyValuesArray:results];
    }];
}

- (void)loadDataFromRemote {
    self.datas = @{}.mutableCopy;
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [SQNetWorkTool requestInterface:@"chart" parameters:@[] callback:^(NSArray * _Nonnull results) {
            dispatch_group_leave(group);
            self.datas[self.tags[0]] = results;
        }];
    });
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        [SQNetWorkTool requestInterface:@"top250" parameters:@[@"0"] callback:^(NSArray * _Nonnull results) {
            dispatch_group_leave(group);
            self.datas[self.tags[1]] = results;
        }];
    });
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.datas writeToFile:@"/System/Volumes/Data/Users/zhushuangquan/Native Drive/GitHub/coderZsq.practice.data/magnet/data/SQHomeData.plist" atomically:YES];
            [self.datas enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSArray *results, BOOL * _Nonnull stop) {
                self.datas[key] = [SQType1Model mj_objectArrayWithKeyValuesArray:results];
            }];
            [self.tableView reloadData];
        });
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 0;
    else return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQType1Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SQType1Cell.class)];
    cell.titleLabel.text = self.tags[indexPath.row];
    cell.datas = self.datas[self.tags[indexPath.row]];
    cell.viewAll = ^{
        SQListViewController *listVC = [[UIStoryboard storyboardWithName:NSStringFromClass(SQListViewController.class) bundle:nil] instantiateInitialViewController];
        listVC.title = self.tags[indexPath.row];
        [self.navigationController pushViewController:listVC animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 270;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) return [SQH1TitleView viewWithTitle:self.title];
    else return [SQSearchInputView inputView];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 64;
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    self.titleLabel.textColor = scrollView.contentOffset.y > -48.f ? self.defaultColor : [UIColor clearColor];
}

@end
