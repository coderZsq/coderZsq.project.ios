//
//  SQPageControl.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//


#import "SQPageControl.h"

@interface SQPageControl ()

@property (nonatomic,strong) NSMutableArray * dotsArr;
@property (nonatomic,strong) UIView         * pageControlView;

@end

@implementation SQPageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.pageControlView];
    }
    return self;
}

- (NSMutableArray *)dotsArr {
    
    if (!_dotsArr) {
        _dotsArr = @[].mutableCopy;
    }
    return _dotsArr;
}

- (UIView *)pageControlView {
    
    if (!_pageControlView) {
        _pageControlView = [UIView new];
    }
    return _pageControlView;
}

- (CGFloat)pageIndicatorSpacing {
    
    if (!_pageIndicatorSpacing) {
        _pageIndicatorSpacing = 10.0f;
    }
    return _pageIndicatorSpacing;
}

- (void)setNumberOfPages:(NSUInteger)numberOfPages {
    
    _numberOfPages = numberOfPages;
    if (numberOfPages != self.dotsArr.count) {
        self.dotsArr = nil;
        for (int i = 0; i < numberOfPages; i++) {
            UIButton * dot = [UIButton buttonWithType:UIButtonTypeCustom];
            [dot setBackgroundImage:self.pageIndicatorTintImage        forState:UIControlStateNormal];
            [dot setBackgroundImage:self.currentPageIndicatorTintImage forState:UIControlStateSelected];
            if (!i) [dot setSelected:YES];
            [self.pageControlView addSubview:dot];
            [self.dotsArr addObject:dot];
        }
    }
}

- (void)setCurrentPageIndicatorTintImage:(UIImage *)currentPageIndicatorTintImage {
    _currentPageIndicatorTintImage = currentPageIndicatorTintImage;
    [self.dotsArr enumerateObjectsUsingBlock:^(UIButton * dot, NSUInteger idx, BOOL * stop) {
        [dot setBackgroundImage:currentPageIndicatorTintImage forState:UIControlStateSelected];
    }];
}

- (void)setPageIndicatorTintImage:(UIImage *)pageIndicatorTintImage {
    _pageIndicatorTintImage = pageIndicatorTintImage;
    [self.dotsArr enumerateObjectsUsingBlock:^(UIButton * dot, NSUInteger idx, BOOL * stop) {
        [dot setBackgroundImage:pageIndicatorTintImage forState:UIControlStateNormal];
    }];
}

- (void)setCurrentPage:(NSUInteger)currentPage {
    _currentPage = currentPage;
    [self.dotsArr enumerateObjectsUsingBlock:^(UIButton * dot, NSUInteger idx, BOOL * stop) {
        dot.selected = idx == currentPage ? YES : NO;
    }];
}

- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage {
    _hidesForSinglePage = hidesForSinglePage;
    if (self.numberOfPages == 1 && hidesForSinglePage) [self.dotsArr removeAllObjects];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIButton * dot = self.dotsArr.firstObject;
    
    CGFloat pageControlViewY = 0;
    CGFloat pageControlViewW = (self.numberOfPages * dot.currentBackgroundImage.size.width) + ((self.numberOfPages - 1) * self.pageIndicatorSpacing);
    CGFloat pageControlViewH = self.height;
    CGFloat pageControlViewX = (self.width - pageControlViewW) * 0.5f;
    self.pageControlView.frame = CGRectMake(pageControlViewX, pageControlViewY, pageControlViewW, pageControlViewH);
    
    for (int i = 0; i < self.dotsArr.count; i++) {
        UIButton * dot = self.dotsArr[i];
        CGFloat dotW = dot.currentBackgroundImage.size.width;
        CGFloat dotH = dot.currentBackgroundImage.size.height;
        CGFloat dotX = i * (dotW + self.pageIndicatorSpacing);
        CGFloat dotY = (self.frame.size.height - dotH) * 0.5f;
        dot.frame = CGRectMake(dotX, dotY, dotW, dotH);
    }
}

@end
