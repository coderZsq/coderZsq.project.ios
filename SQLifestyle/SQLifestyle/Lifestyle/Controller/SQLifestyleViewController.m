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
#import "SQLifestyleDisplayCell.h"
#import "SQLifestyleSearchBarView.h"
#import "SQLifestylePostButton.h"
#import "SQLifestyleGlobal.h"
#import "UIViewController+SQExtension.h"
#import "CAAnimation+SQExtension.h"
#import "CALayer+SQExtension.h"
#import "SQDisplayViewController.h"

@interface SQLifestyleViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray * keysArr;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) SQLifestyleSearchBarView * titleView;
@property (nonatomic,strong) SQLifestyleSearchBarView * searchBarView;
@property (nonatomic,strong) SQLifestylePostButton * postButton;

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
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBarView removeFromSuperview];
    [self.postButton removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:self.tableView];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.view addSubview:self.searchBarView];
    [self.navigationController.view addSubview:self.postButton];
    [self.searchBarView loomingAnimationWithDuration:kTimeInterval];
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
                     kSQLifestyleSearchKey];
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

- (SQLifestylePostButton *)postButton {
    
    CGFloat postButtonW = 40;
    CGFloat postButtonH = postButtonW;
    CGFloat postButtonX = self.view.width - kSpace - postButtonW;
    CGFloat postButtonY = self.view.height - 49 - kSpace - postButtonH;
    
    if (!_postButton) {
        _postButton = [SQLifestylePostButton new];
        _postButton.frame = CGRectMake(postButtonX, postButtonY, postButtonW, postButtonH);
    }
    [CAAnimation animationPopWithLayer:_postButton.layer];
    return _postButton;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = self.view.bounds;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = GLOBAL_BGC;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!section) {
        return self.keysArr.count;
    }
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!indexPath.section) {
        NSString * const key = self.keysArr[indexPath.row];
        if (key == kSQLifestyleBannerKey) {
            SQLifestyleBannerCell * cell = [SQLifestyleBannerCell cellWithTableView:tableView];
            return cell;
        }
        if (key == kSQLifestyleSearchKey) {
            SQLifestyleSearchCell * cell = [SQLifestyleSearchCell cellWithTableView:tableView];
            return cell;
        }
    }
    SQLifestyleDisplayCell * cell = [SQLifestyleDisplayCell cellWithTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!indexPath.section) {
        NSString * const key = self.keysArr[indexPath.row];
        if (key == kSQLifestyleBannerKey) {
            return [SQLifestyleBannerCell cellHeight];
        }
        if (key == kSQLifestyleSearchKey) {
            return [SQLifestyleSearchCell cellHeight];
        }
    }
    return [SQLifestyleDisplayCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[SQDisplayViewController new] animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self navigationBarGradualChangeWithScrollView:scrollView titleView:self.titleView movableView:self.searchBarView offset:kScaleLength(190.5) color:KC01_57c2de];
}

@end
