//
//  MeViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQMeViewController.h"
#import "SQSettingViewController.h"
#import <AFNetworking.h>
#import "SQSquareItem.h"
#import "SQSquareCell.h"
#import <MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface SQMeViewController () <UICollectionViewDataSource>
@property (nonatomic, copy) NSArray * dataSource;
@end

@implementation SQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Me";
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highlightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingBarButtonClick:)], [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(moonBarButtonClick:)]];
    UICollectionViewFlowLayout * flowLayout = ({
        UICollectionViewFlowLayout * flowLayout = [UICollectionViewFlowLayout new];
        NSInteger cols = 4;
        CGFloat margin = 1;
        CGFloat itemWH = (self.view.width - (cols - 1) * margin) / cols;
        flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
        flowLayout.minimumLineSpacing = margin;
        flowLayout.minimumInteritemSpacing = margin;
        flowLayout;
    });
    UICollectionView * collectionView = ({
        UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerNib:[UINib nibWithNibName:@"SQSquareCell" bundle:nil] forCellWithReuseIdentifier:@"identifier"];
        collectionView;
    });
    self.tableView.tableFooterView = collectionView;
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    [manager GET:BaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataSource = [SQSquareItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        [collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count - 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SQSquareItem * item = self.dataSource[indexPath.row];
    SQSquareCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    cell.nameLabel.text = item.name;
    return cell;
}

- (void)moonBarButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)settingBarButtonClick:(UIButton *)sender {
    [self.navigationController pushViewController:[SQSettingViewController new] animated:YES];
}

@end
