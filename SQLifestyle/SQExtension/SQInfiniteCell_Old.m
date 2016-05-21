//
//  SQInfiniteCell_Old.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQInfiniteCell_Old.h"

@interface SQInfiniteCell_Old () <UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray * infiniteLoopArr;
@property (strong, nonatomic) NSTimer        * timer;

@property (strong, nonatomic) UIScrollView   * scrollView;
@property (strong, nonatomic) UIPageControl  * pageControl;
@property (strong, nonatomic) UIButton       * firstPage;
@property (strong, nonatomic) UIButton       * lastPage;

@end

@implementation SQInfiniteCell_Old

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * identifier = NSStringFromClass([SQInfiniteCell_Old class]);
    SQInfiniteCell_Old * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SQInfiniteCell_Old alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeSubviews];
    }
    return self;
}

- (NSMutableArray *)infiniteLoopArr {
    
    if (!_infiniteLoopArr) {
        _infiniteLoopArr = @[].mutableCopy;
    }
    return _infiniteLoopArr;
}

- (NSTimeInterval)timeInterval {
    
    if (!_timeInterval) {
        _timeInterval = 2.5f;
    }
    return _timeInterval;
}

- (void)initializeSubviews {
    [self.contentView addSubview:self.scrollView];
    [self.contentView addSubview:self.pageControl];
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        for (int i = 0; i < 20; i++) {
            UIButton * content = [UIButton buttonWithType:UIButtonTypeCustom];
            content.adjustsImageWhenHighlighted = NO; content.tag = i;
            if ([content isKindOfClass:[UIButton class]]) {
                [_scrollView addSubview:content];
                [self.infiniteLoopArr addObject:content];
            }
            if ([self respondsToSelector:@selector(touchUpInsideEvents:)]) {
                [content addTarget:self action:@selector(touchUpInsideEvents:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        [_scrollView addSubview:self.firstPage];
        [_scrollView addSubview:self.lastPage];
    }
    return _scrollView;
}

- (UIButton *)firstPage {
    
    if (!_firstPage) {
        _firstPage = [UIButton buttonWithType:UIButtonTypeCustom];
        _firstPage.adjustsImageWhenHighlighted = NO;
    }
    return _firstPage;
}

- (UIButton *)lastPage {
    
    if (!_lastPage) {
        _lastPage = [UIButton buttonWithType:UIButtonTypeCustom];
        _lastPage.adjustsImageWhenHighlighted = NO;
    }
    return _lastPage;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl)  _pageControl = [UIPageControl new];
    _pageControl.pageIndicatorTintColor = self.pageIndicatorTintColor;
    _pageControl.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor;
    
    return _pageControl;
}

- (void)setInfiniteLoopData:(NSArray *)infiniteLoopData {
    
    _infiniteLoopData = infiniteLoopData;
    
    [self.timer invalidate];
    [self.firstPage setBackgroundImage:[UIImage imageNamed:[infiniteLoopData firstObject]] forState:UIControlStateNormal];
    [self.lastPage  setBackgroundImage:[UIImage imageNamed:[infiniteLoopData lastObject ]] forState:UIControlStateNormal];
    [infiniteLoopData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self.infiniteLoopArr[idx] setBackgroundImage:[UIImage imageNamed:infiniteLoopData[idx]] forState:UIControlStateNormal];
    }];
    [self setupTimer];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat scrollViewX = 0;
    CGFloat scrollViewY = 0;
    CGFloat scrollViewW = self.contentView.frame.size.width;
    CGFloat scrollViewH = self.contentView.frame.size.height;
    self.scrollView.frame = CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH);
    self.scrollView.contentSize = CGSizeMake(scrollViewW * (self.infiniteLoopData.count + 2), scrollViewH);

    CGFloat pageControlX = 0;
    CGFloat pageControlH = 37;
    CGFloat pageControlY = scrollViewH - pageControlH + 8;
    CGFloat pageControlW = scrollViewW;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    self.pageControl.numberOfPages = self.infiniteLoopData.count;

    [self layoutScrollView];
}

- (void)layoutScrollView {
    
    CGFloat firstBannerButtonX = (self.infiniteLoopData.count + 1) * self.contentView.frame.size.width;
    CGFloat firstBannerButtonY = 0;
    CGFloat firstBannerButtonW = self.contentView.frame.size.width;
    CGFloat firstBannerButtonH = self.contentView.frame.size.height;
    self.firstPage.frame = CGRectMake(firstBannerButtonX, firstBannerButtonY, firstBannerButtonW, firstBannerButtonH);
    
    CGFloat lastBannerButtonX = 0;
    CGFloat lastBannerButtonY = 0;
    CGFloat lastBannerButtonW = firstBannerButtonW;
    CGFloat lastBannerButtonH = firstBannerButtonH;
    self.lastPage.frame = CGRectMake(lastBannerButtonX, lastBannerButtonY, lastBannerButtonW, lastBannerButtonH);
    
    CGFloat bannerY = 0;
    CGFloat bannerW = firstBannerButtonW;
    CGFloat bannerH = firstBannerButtonH;
    [self.infiniteLoopData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat bannerX = firstBannerButtonW * (idx + 1);
        [self.infiniteLoopArr[idx] setFrame:CGRectMake(bannerX, bannerY, bannerW, bannerH)];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = (scrollView.contentOffset.x + self.contentView.frame.size.width * 0.5f) / self.contentView.frame.size.width - 1;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setupTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger page = (scrollView.contentOffset.x) / self.contentView.frame.size.width;
    if (!page) {
        self.scrollView.contentOffset = CGPointMake(self.contentView.frame.size.width * self.infiniteLoopData.count, 0);
        self.pageControl.currentPage = self.infiniteLoopData.count - 1;
    }
    else if (page == self.infiniteLoopData.count + 1) [self returnSettings];
    else self.pageControl.currentPage = page - 1;
}

- (void)setupTimer {
    if ([self respondsToSelector:@selector(updateTimer)]) {
        self.timer = [NSTimer timerWithTimeInterval:self.timeInterval target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)updateTimer {
    
    NSInteger page = self.pageControl.currentPage + 1;
    [UIView animateWithDuration:0.25f animations:^{
        self.scrollView.contentOffset = CGPointMake(self.contentView.frame.size.width * (page + 1), 0);
    }];
    if (page == self.infiniteLoopData.count) [self returnSettings];
    else  self.pageControl.currentPage = page;
}

- (void)returnSettings {
    self.scrollView.contentOffset = CGPointMake(self.contentView.frame.size.width, 0);
    self.pageControl.currentPage = 0;
}

- (void)touchUpInsideEvents:(UIButton *)sender {

    
}

@end
