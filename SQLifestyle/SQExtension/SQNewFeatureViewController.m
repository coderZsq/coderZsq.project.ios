//
//  SQNewFeatureViewController.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQNewFeatureViewController.h"

@interface SQNewFeatureViewController () <UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray * newfeatureArr;

@property (nonatomic,strong) UIScrollView  * scrollView;
@property (nonatomic,strong) UIPageControl * pageControl;
@property (nonatomic,strong) UIButton      * enterButton;

@end

@implementation SQNewFeatureViewController

- (NSMutableArray *)newfeatureArr {
    
    if (!_newfeatureArr) {
        _newfeatureArr = @[].mutableCopy;
    }
    return _newfeatureArr;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.numberOfPages = self.newfeatureImages.count;
    }
    return _pageControl;
}

- (UIButton *)enterButton {
    
    if (!_enterButton) {
        _enterButton = [UIButton new];
        [_enterButton setImage:self.enterButtonImage forState:UIControlStateNormal];
        [_enterButton addTarget:self action:@selector(enterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterButton;
}

- (void)setNewfeatureImages:(NSArray *)newfeatureImages {
    _newfeatureImages = newfeatureImages;
    
    if (self.newfeatureArr.count) return;
    [self.view addSubview:self.scrollView]; [self.view addSubview:self.pageControl];
    for (int i = 0; i < newfeatureImages.count; i++) {
        UIButton * newFeature = [UIButton new];
        [newFeature setAdjustsImageWhenHighlighted:NO];
        [newFeature setBackgroundImage:[UIImage imageNamed:newfeatureImages[i]] forState:UIControlStateNormal];
        if (i == newfeatureImages.count - 1)[newFeature addSubview:self.enterButton];
        [self.scrollView addSubview:newFeature];
        [self.newfeatureArr addObject:newFeature];
    }
}

- (void)setEnterButtonImage:(UIImage *)enterButtonImage {
    _enterButtonImage = enterButtonImage;
    [_enterButton setImage:self.enterButtonImage forState:UIControlStateNormal];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = [UIScreen mainScreen].bounds;
    
    CGFloat pageControlX = 0;
    CGFloat pageControlW = self.scrollView.width;
    CGFloat pageControlH = 100;
    CGFloat pageControlY = self.scrollView.height - pageControlH;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
    
    CGFloat newfeatureY = 0;
    CGFloat newfeatureW = self.scrollView.width;
    CGFloat newfeatureH = self.scrollView.height;
    for (int i = 0; i < self.newfeatureArr.count; i++) {
        UIButton * newfeature = self.newfeatureArr[i];
        CGFloat newfeatureX = i * newfeatureW;
        newfeature.frame = CGRectMake(newfeatureX, newfeatureY, newfeatureW, newfeatureH);
    }
    self.scrollView.contentSize = (CGSize) {newfeatureW * self.newfeatureImages.count,0};
    self.enterButton.center     = (CGPoint){self.view.width * 0.5f ,self.view.height * 0.78f};
    self.enterButton.bounds     = (CGRect) {CGPointZero ,CGSizeMake(80, 80)};
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = (scrollView.contentOffset.x + self.scrollView.width * 0.5f) / self.scrollView.width;
}

- (void)enterButtonClick:(UIButton *)sender {
    if (self.block) {
        self.block();
    }
}

@end
