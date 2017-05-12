//
//  CollectionViewTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockThreeCollectionView.h"
#import "HYBlockThreeCollectionCell.h"

@interface HYBlockThreeCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout * collectionViewLayout;

@end

@implementation HYBlockThreeCollectionView

- (void)dealloc {
    NSLog(@"%@ - execute %s",NSStringFromClass([self class]),__func__);
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder  {
    
    self = [super initWithCoder:coder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[HYBlockThreeCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([HYBlockThreeCollectionCell class])];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionViewLayout {
    
    if (!_collectionViewLayout) {
        _collectionViewLayout = [UICollectionViewFlowLayout new];
        _collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionViewLayout.minimumInteritemSpacing = 0.0f;
        _collectionViewLayout.minimumLineSpacing = 0.0f;
    }
    return _collectionViewLayout;
}

- (void)setupSubviews {
    [self addSubview:self.collectionView];
}

- (void)setDataSourceArr:(NSArray *)dataSourceArr {
    _dataSourceArr = dataSourceArr;
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSourceArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HYBlockThreeCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HYBlockThreeCollectionCell class]) forIndexPath:indexPath];
    return cell;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
    _collectionViewLayout.itemSize = CGSizeMake(100, 100);

}

@end
