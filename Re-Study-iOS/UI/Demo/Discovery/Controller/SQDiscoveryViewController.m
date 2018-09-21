//
//  SQDiscoveryViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQDiscoveryViewController.h"
#import "SQDiscoveryItem.h"
#import "SQDiscoveryThemeItem.h"
#import "SQDiscoveryCell.h"

@interface SQDiscoveryViewController ()
@property (nonatomic, copy) NSArray * dataSource;
@end

@implementation SQDiscoveryViewController

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [SQDiscoveryItem getDiscoveryList];
    }
    return _dataSource;
}

- (instancetype)init {
    UICollectionViewFlowLayout * flowLayout = [UICollectionViewFlowLayout new];
    CGFloat margin = 10.;
    CGFloat width = (ScreenWidth - 3 * margin) * .5;
    CGFloat height = width * .6 + 50;
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    return [super initWithCollectionViewLayout:flowLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Discovery";
    self.collectionView.backgroundColor = BackgroundColor;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SQDiscoveryCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SQDiscoveryCell class])];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SQDiscoveryItem * item = self.dataSource[section];
    return item.themes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SQDiscoveryItem * item = self.dataSource[indexPath.section];
    SQDiscoveryThemeItem * themeItem = item.themes[indexPath.row];
    SQDiscoveryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SQDiscoveryCell class]) forIndexPath:indexPath];
    cell.iconImageView.image = [UIImage imageNamed:themeItem.img];
    cell.nameLabel.text = themeItem.title;
    cell.descLabel.text = themeItem.keywords;
    return cell;
}

@end
