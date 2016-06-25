//
//  SQLifestyleViewController.m
//  SQLifestyle
//
//  Created by Doubles_Z on 16-5-22.
//  Copyright (c) 2016年 Doubles_Z. All rights reserved.
//

#import "SQLifestyleViewController.h"
#import "SQLifestyleBannerCell.h"
#import "SQLifestyleSearchCell.h"
#import "SQLifestyleSearchBarView.h"
#import "SQLifestyleGlobal.h"
#import "UIViewController+SQExtension.h"

@interface SQLifestyleViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray * keysArr;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) SQLifestyleSearchBarView * titleView;
@property (nonatomic,strong) SQLifestyleSearchBarView * searchBarView;

@end

@implementation SQLifestyleViewController

- (void)loadView {
    [super loadView];
    [self.navigationItem setTitleView:self.titleView];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.navigationController.view addSubview:self.searchBarView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat searchBarViewX = kSpace;
    CGFloat searchBarViewW = self.titleView.width;
    CGFloat searchBarViewH = self.titleView.height;
    CGFloat searchBarViewY = kScaleLength(210) + searchBarViewH - self.tableView.contentOffset.y - searchBarViewH;
    self.searchBarView.frame = CGRectMake(searchBarViewX, searchBarViewY, searchBarViewW, searchBarViewH);
}

- (NSArray *)keysArr {
    
    if (!_keysArr) {
        _keysArr = @[kSQLifestyleBannerKey,
                     kSQLifestyleSearchKey,
                     @"",@"",@"",@"",@"",
                     @"",@"",@"",@"",@"",
                     @"",@"",@"",@"",@"",
                     @"",@"",@"",@"",@""];
    }
    return _keysArr;
}

- (SQLifestyleSearchBarView *)titleView {
    
    if (!_titleView) {
        _titleView = [SQLifestyleSearchBarView new];
        _titleView.frame = self.navigationController.navigationBar.frame;
    }
    return _titleView;
}

- (SQLifestyleSearchBarView *)searchBarView {
    
    if (!_searchBarView) {
        _searchBarView = [SQLifestyleSearchBarView new];
    }
    return _searchBarView;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = self.view.bounds;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.keysArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString * const key = self.keysArr[indexPath.row];
    if (key == kSQLifestyleBannerKey) {
        SQLifestyleBannerCell * cell = [SQLifestyleBannerCell cellWithTableView:tableView];
        return cell;
    }
    if (key == kSQLifestyleSearchKey) {
        SQLifestyleSearchCell * cell = [SQLifestyleSearchCell cellWithTableView:tableView];
        return cell;
    }
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }   cell.textLabel.text = @"https://coderZsq.github.io";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * const key = self.keysArr[indexPath.row];
    if (key == kSQLifestyleBannerKey) {
        return [SQLifestyleBannerCell cellHeight];
    }
    if (key == kSQLifestyleSearchKey) {
        return [SQLifestyleSearchCell cellHeight];
    }
    return 44;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self viewWillLayoutSubviews];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self navigationBarGradualChangeWithScrollView:scrollView titleView:self.titleView movableView:self.searchBarView offset:kScaleLength(190.5) color:KC01_57c2de];
}

@end
