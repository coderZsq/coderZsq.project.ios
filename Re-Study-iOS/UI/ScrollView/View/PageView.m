//
//  PageView.m
//  UI
//
//  Created by 朱双泉 on 2018/9/6.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "PageView.h"
#import "Proxy.h"

@interface PageView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer * timer;
@end

@implementation PageView

- (void)dealloc {
    [self stopTimer];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.pageControl.hidesForSinglePage = YES;
    [self.pageControl setValue:[UIImage imageNamed:@"current"] forKey:@"_currentPageImage"];
    [self.pageControl setValue:[UIImage imageNamed:@"other"] forKey:@"_pageImage"];
    [self startTimer];
}

+ (instancetype)pageView {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setImageNames:(NSArray *)imageNames {
    _imageNames = [imageNames copy];
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat scrollViewW = self.scrollView.frame.size.width;
    CGFloat scrollViewH = self.scrollView.frame.size.height;
    
    NSUInteger count = imageNames.count;
    for (NSInteger i = 0; i < count; i++) {
        UIImageView * imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"Avatar"];
        imageView.contentMode = UIViewContentModeBottom;
        imageView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
    self.pageControl.numberOfPages = count;
}

- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2. target:[Proxy proxyWithTarget:self] selector:@selector(nextPage:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];
}

- (void)nextPage:(NSTimer *)sender {
    NSInteger page = self.pageControl.currentPage + 1;
    if (page == self.pageControl.numberOfPages) {
        page = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(page * self.scrollView.frame.size.width, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = self.scrollView.contentOffset.x / self.scrollView.frame.size.width + .5;
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
    if (!decelerate) {
        NSInteger page = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
        self.pageControl.currentPage = page;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}
@end
