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
#import "SQDiscoveryHeaderView.h"
#import "SQDiscoveryHeaderItem.h"

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
    flowLayout.headerReferenceSize = CGSizeMake(ScreenWidth, 240);
    return [super initWithCollectionViewLayout:flowLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Discovery";
    self.collectionView.backgroundColor = BackgroundColor;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SQDiscoveryCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SQDiscoveryCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SQDiscoveryHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SQDiscoveryHeaderView class])];
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SQDiscoveryItem * item = self.dataSource[indexPath.section];
        SQDiscoveryHeaderItem * headerItem = item.header;
        SQDiscoveryHeaderView * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([SQDiscoveryHeaderView class]) forIndexPath:indexPath];
        view.iconImageView.image = [UIImage imageNamed:headerItem.image];
        view.nameLabel.text = headerItem.feeltitle;
        view.descLabel.text = headerItem.title;
        return view;
    }
    return nil;
}

@end
