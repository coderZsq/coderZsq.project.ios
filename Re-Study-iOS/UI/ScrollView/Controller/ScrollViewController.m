//
//  ScrollViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/6.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ScrollViewController.h"
#import "PageView.h"
#import "Proxy.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>

@interface ScrollViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView * scrollView2;
@property (nonatomic, weak) UIScrollView * scrollView3;
@property (nonatomic, weak) UIImageView * imageView;
@property (nonatomic, weak) UIPageControl * pageControl;
@property (nonatomic, weak) NSTimer * timer;
@property (nonatomic, weak) NSLayoutConstraint * wlc;
@property (nonatomic, weak) NSLayoutConstraint * hlc;
@end

@implementation ScrollViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
    [self stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    UIScrollView * scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    
    NSLayoutConstraint * xlc = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1. constant:30.];
    NSLayoutConstraint * ylc = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1. constant:100.];
    NSLayoutConstraint * wlc = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:.0 constant:100.];
    _wlc = wlc;
    NSLayoutConstraint * hlc = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:.0 constant:100.];
    _hlc = hlc;
    [self.view addConstraints:@[xlc, ylc]];
    [scrollView addConstraints:@[wlc, hlc]];

    UIButton * darkGrayButton = [UIButton new];
    darkGrayButton.frame = CGRectMake(0, 0, 44, 44);
    darkGrayButton.backgroundColor = [UIColor darkGrayColor];
    [darkGrayButton addTarget:self action:@selector(darkGrayButtonTouchDragInside:) forControlEvents:UIControlEventTouchDragInside];
    [darkGrayButton addTarget:self action:@selector(darkGrayButtonTouchDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
    [scrollView addSubview:darkGrayButton];

    scrollView.clipsToBounds = NO;
    scrollView.contentSize = CGSizeMake(125, 125);
    
//    scrollView.scrollEnabled = NO;
//    scrollView.userInteractionEnabled = NO;
    
    UIScrollView * scrollView2 = [UIScrollView new];
    scrollView2.backgroundColor = [UIColor lightGrayColor];
    scrollView2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView2];
    _scrollView2 = scrollView2;
    
    NSString * hvfl = @"H:[scrollView]-hspace-[scrollView2(100)]";
    NSString * vvfl = @"V:|-vspace-[scrollView2(100)]";
    NSDictionary * metrics = @{@"hspace": @10, @"vspace" : @100};
//    NSDictionary * views = @{@"scrollView" : scrollView, @"scrollView2" : scrollView2};
    NSDictionary * views = NSDictionaryOfVariableBindings(scrollView, scrollView2);
    NSArray * hlcs = [NSLayoutConstraint constraintsWithVisualFormat:hvfl options:kNilOptions metrics:metrics views:views];
    [self.view addConstraints:hlcs];
    NSArray * vlcs = [NSLayoutConstraint constraintsWithVisualFormat:vvfl options:kNilOptions metrics:metrics views:views];
    [self.view addConstraints:vlcs];

    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Avatar"]];
    [scrollView2 addSubview:imageView];
    _imageView = imageView;

    scrollView2.contentSize = imageView.image.size;
//    scrollView2.bounces = NO;
    
    UIActivityIndicatorView * indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.center = CGPointMake(50, -40);
    [indicatorView startAnimating];
    [scrollView2 addSubview:indicatorView];
    
    scrollView2.alwaysBounceVertical = YES;
    scrollView2.alwaysBounceHorizontal = YES;

    scrollView2.showsVerticalScrollIndicator = NO;
    scrollView2.showsHorizontalScrollIndicator = NO;

    scrollView2.contentOffset = CGPointMake(200, 150);
    scrollView2.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    scrollView2.delegate = self;
    
    scrollView2.maximumZoomScale = 2.0;
    scrollView2.minimumZoomScale = 0.5;
    
    UIView * contentView = [UIView new];
    contentView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 125, 100, 100, 100);
    contentView.backgroundColor = [UIColor lightGrayColor];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
#if 0
    typedef NS_OPTIONS(NSUInteger, UIViewAutoresizing) {
        UIViewAutoresizingNone                 = 0,
        UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
        UIViewAutoresizingFlexibleWidth        = 1 << 1,
        UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
        UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
        UIViewAutoresizingFlexibleHeight       = 1 << 4,
        UIViewAutoresizingFlexibleBottomMargin = 1 << 5
    };
#endif
    
    for (NSString * direction in @[@"↖", @"↑", @"↗", @"←", @"·", @"→", @"↙", @"↓", @"↘"]) {
        UIButton * button = [UIButton new];
        [button setTitle:direction forState:UIControlStateNormal];
        [button addTarget:self action:@selector(directionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:button];

        NSUInteger matrix = 3;
        CGFloat width = contentView.frame.size.width / matrix;
        CGFloat height = width;
        NSUInteger index = contentView.subviews.count - 1;
        NSUInteger col = index % matrix;
        CGFloat x = col * width;
        NSUInteger row = index / matrix;
        CGFloat y = row * height;

        button.frame = CGRectMake(x, y, width, height);
    }
    [self.view addSubview:contentView];
    
    UIScrollView * scrollView3 = [UIScrollView new];
//    scrollView3.frame = CGRectMake(30, 210, 320, 120);
    scrollView3.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scrollView3];
    _scrollView3 = scrollView3;
    
    [scrollView3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView.bottom).offset(10);
        make.left.equalTo(scrollView);
        make.right.equalTo(contentView);
        make.height.equalTo(120);
    }];
#if 0
    [scrollView3 updateConstraints:^(MASConstraintMaker *make) {}];
    [scrollView3 remakeConstraints:^(MASConstraintMaker *make) {}];
#endif
    [scrollView3 layoutIfNeeded];
    CGFloat scrollView3W = scrollView3.frame.size.width;
    CGFloat scrollView3H = scrollView3.frame.size.height;

    NSUInteger count = 5;
    for (NSInteger i = 0; i < count; i++) {
        UIImageView * imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"Avatar"];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.frame = CGRectMake(i * scrollView3W, 0, scrollView3W, scrollView3H);
        [scrollView3 addSubview:imageView];
    }
    
    scrollView3.contentSize = CGSizeMake(count * scrollView3W, 0);
    scrollView3.showsHorizontalScrollIndicator = NO;
    
    scrollView3.pagingEnabled = YES;
    scrollView3.delegate = self;
    
    UIPageControl * pageControl = [UIPageControl new];
    pageControl.frame = CGRectMake(30, 310, 320, 0);
    pageControl.numberOfPages = count;
    pageControl.hidesForSinglePage = YES;
    pageControl.enabled = NO;
    [self.view addSubview:pageControl];
    _pageControl = pageControl;
    
    [pageControl setValue:[UIImage imageNamed:@"current"] forKey:@"_currentPageImage"];
    [pageControl setValue:[UIImage imageNamed:@"other"] forKey:@"_pageImage"];
    
    [self startTimer];
    
    PageView * pageView = [PageView pageView];
    pageView.imageNames = @[@"Avatar", @"Avatar", @"Avatar"];
    pageView.backgroundColor = [UIColor lightGrayColor];
    pageView.frame = CGRectMake(30, 340, 320, 120);
    [self.view addSubview:pageView];
    
    [pageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView3.bottom).offset(10);
        make.left.width.height.equalTo(scrollView3);
    }];
}

- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2. target:[Proxy proxyWithTarget:self] selector:@selector(nextPage:) userInfo:@"userInfo" repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];
//    self.timer = nil;
}

- (void)nextPage:(NSTimer *)sender {
//    NSLog(@"%@", sender.userInfo);
    NSInteger page = self.pageControl.currentPage + 1;
    if (page == self.pageControl.numberOfPages) {
        page = 0;
    }
    [self.scrollView3 setContentOffset:CGPointMake(page * self.scrollView3.frame.size.width, 0) animated:YES];
}

- (void)darkGrayButtonTouchDragInside:(UIButton *)sender {
    self.wlc.constant = 44.;
    self.hlc.constant = 44.;
    [UIView animateWithDuration:1. animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)darkGrayButtonTouchDragOutside:(UIButton *)sender {
    self.wlc.constant = 100.;
    self.hlc.constant = 100.;
    [UIView animateWithDuration:1. animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)directionButtonClick:(UIButton *)sender {
    NSString * direction = sender.titleLabel.text;
    if ([direction isEqualToString:@"↖"]) {
        [self.scrollView2 setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if ([direction isEqualToString:@"↑"]) {
        [self.scrollView2 setContentOffset:CGPointMake(self.scrollView2.contentOffset.x, 0) animated:YES];
    } else if ([direction isEqualToString:@"↗"]) {
        CGFloat offsetX = self.scrollView2.contentSize.width - self.scrollView2.frame.size.width;
        [self.scrollView2 setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    } else if ([direction isEqualToString:@"←"]) {
        [self.scrollView2 setContentOffset:CGPointMake(0, self.scrollView2.contentOffset.y) animated:YES];
    } else if ([direction isEqualToString:@"→"]) {
        CGFloat offsetX = self.scrollView2.contentSize.width - self.scrollView2.frame.size.width;
        [self.scrollView2 setContentOffset:CGPointMake(offsetX, self.scrollView2.contentOffset.y) animated:YES];
    } else if ([direction isEqualToString:@"↙"]) {
        CGFloat offsetY = self.scrollView2.contentSize.height - self.scrollView2.frame.size.height;
        [self.scrollView2 setContentOffset:CGPointMake(0, offsetY) animated:YES];
    } else if ([direction isEqualToString:@"↓"]) {
        CGFloat offsetY = self.scrollView2.contentSize.height - self.scrollView2.frame.size.height;
        [self.scrollView2 setContentOffset:CGPointMake(self.scrollView2.contentOffset.x, offsetY) animated:YES];
    } else if ([direction isEqualToString:@"↘"]) {
        CGFloat offsetX = self.scrollView2.contentSize.width - self.scrollView2.frame.size.width;
        CGFloat offsetY = self.scrollView2.contentSize.height - self.scrollView2.frame.size.height;
        [self.scrollView2 setContentOffset:CGPointMake(offsetX, offsetY) animated:YES];
    } else  {
        self.scrollView2.zoomScale = 1.0;
        [self.scrollView2 setContentOffset:CGPointMake(200, 150) animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%s", __func__);
    if (scrollView == self.scrollView3) {
        NSInteger page = self.scrollView3.contentOffset.x / self.scrollView3.frame.size.width + .5;
        self.pageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
    [self stopTimer];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"%s", __func__);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self startTimer];
    if (!decelerate) {
        NSLog(@"%s - decelerated", __func__);
        if (scrollView == self.scrollView3) {
            NSInteger page = self.scrollView3.contentOffset.x / self.scrollView3.frame.size.width;
            self.pageControl.currentPage = page;
        }
    }
    else
        NSLog(@"%s", __func__);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
    if (scrollView == self.scrollView3) {
        NSInteger page = self.scrollView3.contentOffset.x / self.scrollView3.frame.size.width;
        self.pageControl.currentPage = page;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
}

@end
