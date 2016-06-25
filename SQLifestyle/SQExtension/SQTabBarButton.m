//
//  SQTabBarButton.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQTabBarButton.h"
#import "SQBadgeView.h"

@interface SQTabBarButton ()

@property (nonatomic,strong) SQBadgeView * badgeView;

@end

@implementation SQTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareForSetup];
    }
    return self;
}

- (void)prepareForSetup {
    
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [self addSubview:self.badgeView];
}

- (SQBadgeView *)badgeView {
    
    if (!_badgeView) {
        _badgeView = [SQBadgeView new];
    }
    return _badgeView;
}

static const double ratio = 0.7f;
- (CGRect)imageRectForContentRect:(CGRect)contentRect {

    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * ratio;
    return CGRectMake(0, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {

    CGFloat titleY = contentRect.size.height * ratio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

- (void)setHighlighted:(BOOL)highlighted {};

- (void)setItem:(UITabBarItem *)item {
    
    _item = item;
    
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    [self setTitle:self.item.title            forState:UIControlStateNormal];
    [self setTitle:self.item.title            forState:UIControlStateSelected];
    [self setImage:self.item.image            forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage    forState:UIControlStateSelected];
    [self setTitleColor:KC04_999999           forState:UIControlStateNormal];
    [self setTitleColor:KC01_57c2de           forState:UIControlStateSelected];
    
    self.badgeView.badgeValue = self.item.badgeValue;

}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect badgeViewFrame = self.badgeView.frame;
    badgeViewFrame.origin.x = self.width * 0.5f + 2;
    badgeViewFrame.origin.y = 2;
    self.badgeView.frame = badgeViewFrame;
}

- (void)dealloc {
    
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}



@end
