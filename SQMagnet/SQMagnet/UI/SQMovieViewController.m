//
//  SQMovieViewController.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQMovieViewController.h"
#import "UIViewController+SQExtension.h"
#import "SQListViewController.h"
#import "SQH1TitleView.h"
#import "SQType1Cell.h"
#import "SQType1Model.h"
#import "SQNetWorkTool.h"
#import <MJExtension/MJExtension.h>

@interface SQMovieViewController ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIColor *defaultColor;
@property (nonatomic, strong) NSMutableDictionary *datas;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, copy) NSString *type;

@end

@implementation SQMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电影";
    self.type = @"movie";
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

    [self loadDataFromLocal];
//    [self loadDataFromRemote];
}

- (void)loadDataFromLocal {
    self.tags = [NSArray arrayWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"SQMovieTag" ofType:@"plist"]];
    self.datas = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"SQMovieData" ofType:@"plist"]].mutableCopy;
    [self.datas enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSArray *results, BOOL * _Nonnull stop) {
        self.datas[key] = [SQType1Model mj_objectArrayWithKeyValuesArray:results];
    }];
}

- (void)loadDataFromRemote {
    self.datas = @{}.mutableCopy;
    [SQNetWorkTool requestInterface:@"tags" parameters:@[self.type] callback:^(NSArray * _Nonnull results) {
        [results writeToFile:@"/System/Volumes/Data/Users/zhushuangquan/Native Drive/GitHub/coderZsq.practice.data/magnet/data/SQMovieTag.plist" atomically:YES];
        self.tags = results;
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        for (NSString *tag in self.tags) {
            dispatch_group_async(group, queue, ^{
                dispatch_group_enter(group);
                [SQNetWorkTool requestInterface:self.type parameters:@[tag, @"0"] callback:^(NSArray * _Nonnull results) {
                    dispatch_group_leave(group);
                    self.datas[tag] = results;
                }];
            });
        }
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.datas writeToFile:@"/System/Volumes/Data/Users/zhushuangquan/Native Drive/GitHub/coderZsq.practice.data/magnet/data/SQMovieData.plist" atomically:YES];
                [self.datas enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSArray *results, BOOL * _Nonnull stop) {
                    self.datas[key] = [SQType1Model mj_objectArrayWithKeyValuesArray:results];
                }];
                [self.tableView reloadData];
            });
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQType1Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SQType1Cell.class)];
    cell.titleLabel.text = [self.tags[indexPath.row] stringByReplacingOccurrencesOfString:@"豆瓣" withString:@""];
    cell.datas = self.datas[self.tags[indexPath.row]];
    cell.viewAll = ^{
        SQListViewController *listVC = [[UIStoryboard storyboardWithName:NSStringFromClass(SQListViewController.class) bundle:nil] instantiateInitialViewController];
        listVC.title = [self.tags[indexPath.row] stringByReplacingOccurrencesOfString:@"豆瓣" withString:@""];;
        listVC.type = self.type;
        [self.navigationController pushViewController:listVC animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 270;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [SQH1TitleView viewWithTitle:self.title];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.titleLabel.textColor = scrollView.contentOffset.y > -48.f ? self.defaultColor : [UIColor clearColor];
}

@end
