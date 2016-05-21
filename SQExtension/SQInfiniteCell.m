//
//  SQInfiniteCell.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQInfiniteCell.h"

static const int   kRatio  = 1000;
static const float kHeight = 150;

@interface SQInfiniteCell () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView           * collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout * flowLayout;
@property (nonatomic,strong) UIPageControl              * pageControl;

@property (nonatomic,strong) NSTimer * timer;

@property (nonatomic,assign,getter = isFirstEnter) BOOL firstEnter;

@end

@implementation SQInfiniteCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * identifier = NSStringFromClass([SQInfiniteCell class]);
    SQInfiniteCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SQInfiniteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupTimer];
        [self setupSubviews];
        [self setFirstEnter:YES];
        [self.layer setShouldRasterize:YES];
        [self.layer setRasterizationScale:[UIScreen mainScreen].scale];
    }
    return self;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, kHeight) collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    
    if (!_flowLayout) {
        _flowLayout = [UICollectionViewFlowLayout new];
        _flowLayout.minimumLineSpacing = 0.0f;
        _flowLayout.minimumInteritemSpacing = 0.0f;
        _flowLayout.itemSize = self.collectionView.bounds.size;
        _flowLayout.sectionInset = UIEdgeInsetsZero;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.defersCurrentPageDisplay = YES;
    }
    return _pageControl;
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

- (void)setupSubviews {
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.pageControl];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat pageControlX = 0;
    CGFloat pageControlH = 37;
    CGFloat pageControlY = self.collectionView.bounds.size.height - pageControlH;
    CGFloat pageControlW = self.collectionView.bounds.size.width;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    
    _dataSource = dataSource;
    _pageControl.numberOfPages = self.dataSource.count;
    
    if (self.isFirstEnter) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataSource.count * kRatio inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        self.firstEnter = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.pageControl.currentPage = ((NSInteger)((scrollView.contentOffset.x + self.contentView.frame.size.width) / self.contentView.frame.size.width) - 1) % self.dataSource.count;
    
    if (scrollView.contentOffset.x == 0 || scrollView.contentOffset.x == scrollView.contentSize.width - self.contentView.bounds.size.width) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataSource.count * kRatio inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count * kRatio * 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.contents = (__bridge id)[UIImage imageNamed:[NSString stringWithFormat:@"img_0%li",(long)(indexPath.item % self.dataSource.count)]].CGImage;
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setupTimer];
}

- (void)setupTimer {
    if ([self respondsToSelector:@selector(updateTimer)]) {
        self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)updateTimer {
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x + self.contentView.frame.size.width, 0) animated:YES];
}

@end
