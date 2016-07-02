//
//  SQLifestyleBannerCell.m
//  SQLifestyle
//
//  Created by Doubles_Z on 16-6-8.
//  Copyright (c) 2016年 Doubles_Z. All rights reserved.
//

#import "SQLifestyleBannerCell.h"

@interface SQLifestyleBannerCell () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout * flowLayout;
@property (nonatomic,strong) UIImageView * reliefArcImageView;
@property (nonatomic,strong) UIPageControl * pageControl;

@property (nonatomic,strong) NSTimer * timer;

@end

static const NSInteger kMultiply = 500;
static const NSInteger kCounts = 5;

@implementation SQLifestyleBannerCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * identifier = NSStringFromClass([SQLifestyleBannerCell class]);
    SQLifestyleBannerCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SQLifestyleBannerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupTimer];
        [self setupSubviews];
    }
    return self;
}

- (UICollectionViewFlowLayout *)flowLayout {
    
    if (!_flowLayout) {
        _flowLayout = [UICollectionViewFlowLayout new];
        _flowLayout.minimumInteritemSpacing = 0.0f;
        _flowLayout.minimumLineSpacing = 0.0f;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (UIImageView *)reliefArcImageView {
    
    if (!_reliefArcImageView) {
        _reliefArcImageView = [UIImageView new];
        _reliefArcImageView.image = [UIImage imageNamed:kLifestyle_relief];
        _reliefArcImageView.userInteractionEnabled = NO;
    }
    return _reliefArcImageView;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.defersCurrentPageDisplay = YES;
        _pageControl.numberOfPages = kCounts;
        _pageControl.pageIndicatorTintColor = KC05_dddddd;
        _pageControl.currentPageIndicatorTintColor = KC01_57c2de;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

- (void)setupSubviews {
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.reliefArcImageView];
    [self.contentView addSubview:self.pageControl];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kCounts * kMultiply;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.layer.contents = (__bridge id)[UIImage imageNamed:@"banner"].CGImage;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.pageControl.currentPage = ((NSInteger)((scrollView.contentOffset.x + self.contentView.frame.size.width) / self.contentView.frame.size.width) - 1) % kCounts;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setupTimer];
}

- (void)setupTimer {
    if ([self respondsToSelector:@selector(updateTimer)]) {
        self.timer = [NSTimer timerWithTimeInterval:5.0f target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)updateTimer {

    NSInteger item = (self.collectionView.contentOffset.x + self.contentView.frame.size.width) * (kCounts * kMultiply)/ self.collectionView.contentSize.width;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.flowLayout.itemSize = self.contentView.bounds.size;
    self.collectionView.frame = self.contentView.bounds;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:kCounts * kMultiply * 0.5f inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    CGFloat reliefArcImageViewX = 0;
    CGFloat reliefArcImageViewH = kScaleLength(50);
    CGFloat reliefArcImageViewY = self.height - reliefArcImageViewH;
    CGFloat reliefArcImageViewW = self.width;
    self.reliefArcImageView.frame = CGRectMake(reliefArcImageViewX, reliefArcImageViewY, reliefArcImageViewW, reliefArcImageViewH);
    
    CGFloat pageControlX = 0;
    CGFloat pageControlH = 35;
    CGFloat pageControlY = self.collectionView.bounds.size.height - pageControlH;
    CGFloat pageControlW = self.collectionView.bounds.size.width;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
}

+ (CGFloat)cellHeight {
	return kScaleLength(210);
}

@end
