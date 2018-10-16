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
#import <SafariServices/SafariServices.h>
#import "SQWebViewController.h"

static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (self.view.width - (cols - 1) * margin) / cols

@interface SQMeViewController () <UICollectionViewDataSource, UICollectionViewDelegate/*, SFSafariViewControllerDelegate*/>
@property (nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation SQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Me";
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highlightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingBarButtonClick:)], [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(moonBarButtonClick:)]];
    UICollectionViewFlowLayout * flowLayout = ({
        UICollectionViewFlowLayout * flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
        flowLayout.minimumLineSpacing = margin;
        flowLayout.minimumInteritemSpacing = margin;
        flowLayout;
    });
    UICollectionView * collectionView = ({
        UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerNib:[UINib nibWithNibName:@"SQSquareCell" bundle:nil] forCellWithReuseIdentifier:@"identifier"];
        collectionView;
    });
    self.tableView.tableFooterView = collectionView;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    [manager GET:BaseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataSource = [SQSquareItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        [self.dataSource removeLastObject];
        NSInteger count = self.dataSource.count;
        NSInteger extre = count % cols;
        if (extre) {
            extre = cols - extre;
            for (int i = 0; i < extre; i++) {
                [self.dataSource addObject:[SQSquareItem new]];
            }
        }
        NSInteger rows = (count - 1) / cols + 1;
        CGFloat collectionH = rows * itemWH + (rows - 1) * margin;
        collectionView.height = collectionH;
//        self.tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(collectionView.frame));
        self.tableView.tableFooterView = collectionView;
        [collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SQSquareItem * item = self.dataSource[indexPath.row];
    SQSquareCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    cell.nameLabel.text = item.name;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SQSquareItem * item = self.dataSource[indexPath.row];
    NSURL * url = [NSURL URLWithString:item.url];
    NSLog(@"%@", url);
    
    CGFloat systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
    
    SQWebViewController * vc = [SQWebViewController new];
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
    return;
    
    if (systemVersion >= 9.0) {
        SFSafariViewController * vc = [[SFSafariViewController alloc]initWithURL:url];
        //    vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
        //    [self.navigationController pushViewController:vc animated:YES];
    } else if (systemVersion >= 8.0) {
        
    }
}

//- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)moonBarButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)settingBarButtonClick:(UIButton *)sender {
    [self.navigationController pushViewController:[SQSettingViewController new] animated:YES];
}

@end
