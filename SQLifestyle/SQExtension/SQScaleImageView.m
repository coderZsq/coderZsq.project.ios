//
//  SQScaleImageView.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//


#import "SQScaleImageView.h"
#import "SQScaleTableHeaderView.h"

@interface SQScaleImageView ()
@property (nonatomic,strong) SQScaleTableHeaderView * tableHeaderView;
@end

static CGFloat const upFactor    = 0.5;
static CGFloat const scaleFactor = 0.005;

@implementation SQScaleImageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareLayout];
    }
    return self;
}

- (void)prepareLayout {
    
    CGFloat screenWidth    = [UIScreen mainScreen].bounds.size.width;
    self.bounds            = (CGRect) {CGPointZero,screenWidth,screenWidth};
    self.layer.position    = (CGPoint){screenWidth * 0.5f, - screenWidth * 0.25f};
    self.layer.anchorPoint = (CGPoint){0.5f, 0};
}

- (SQScaleTableHeaderView *)tableHeaderView {
    
    if (!_tableHeaderView) {
        _tableHeaderView = [SQScaleTableHeaderView new];
    }
    return _tableHeaderView;
}

- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    [tableView insertSubview:self atIndex:0];
    [tableView setTableHeaderView:self.tableHeaderView];
}

- (void)scaleWithScrollViewContentOffset:(CGPoint)contentOffset {
    
    CGFloat contentOffsetY = contentOffset.y;
    CGFloat point          = -(self.frame.size.height / 6) / (1 - upFactor);

    if (contentOffsetY > 0) return;
    if (contentOffsetY >= point) {
        self.transform = CGAffineTransformMakeTranslation(0, contentOffsetY * upFactor);
    } else {
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, contentOffsetY - point * (1 - upFactor));
        CGFloat scale = 1 + (point - contentOffsetY) * scaleFactor;
        self.transform = CGAffineTransformScale(transform, scale, scale);
    }
}

@end
