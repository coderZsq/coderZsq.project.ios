//
//  SQSwiperView.m
//  Mall
//
//  Created by 朱双泉 on 12/10/2017.
//  Copyright © 2017 _Zhizi_. All rights reserved.
//

#import "SQSwiperView.h"
static const int ratio  = 1000;

@interface SQSwiperCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView * imageView;
@end

@interface SQSwiperView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView           * collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout * flowLayout;
@property (nonatomic,strong) UIPageControl              * pageControl;

@property (nonatomic,strong) NSTimer * timer;
@end

@implementation SQSwiperView

- (void)dealloc {
#if DEBUG
    NSLog(@"--------");
    NSLog(@"%@ - execute %s",NSStringFromClass([self class]),__func__);
    NSLog(@"--------");
#endif
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
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.layer.contents = (__bridge id)[UIImage imageNamed:@"placeholder_320_150"].CGImage;
        [_collectionView registerClass:[SQSwiperCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    
    if (!_flowLayout) {
        _flowLayout = [UICollectionViewFlowLayout new];
        _flowLayout.minimumLineSpacing = 0.0f;
        _flowLayout.minimumInteritemSpacing = 0.0f;
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


- (void)setupSubviews {
    [self setupTimer];
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _collectionView.frame = self.bounds;
    _flowLayout.itemSize = self.bounds.size;
    
    CGFloat pageControlX = 0;
    CGFloat pageControlH = 37;
    CGFloat pageControlY = self.collectionView.bounds.size.height - pageControlH;
    CGFloat pageControlW = self.collectionView.bounds.size.width;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    _pageControl.numberOfPages = numberOfPages;
    [_collectionView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.numberOfPages) return;
    self.pageControl.currentPage = ((NSInteger)((scrollView.contentOffset.x + self.frame.size.width) / self.frame.size.width) - 1) % self.numberOfPages;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.numberOfPages * ratio * 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SQSwiperCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (_loadImage) {
        _loadImage(cell.imageView, indexPath.item % _numberOfPages);
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (_didSelect) {
        _didSelect(indexPath.item % _numberOfPages);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setupTimer];
}

- (void)setupTimer {
    if ([self respondsToSelector:@selector(updateTimer)]) {
        self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)updateTimer {
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x + self.frame.size.width, 0) animated:YES];
}

@end

@implementation SQSwiperCell

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

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (void)setupSubviews {
    [self addSubview:self.imageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.contentView.bounds;
}

@end
