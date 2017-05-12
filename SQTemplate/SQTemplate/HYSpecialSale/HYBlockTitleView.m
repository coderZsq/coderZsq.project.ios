//
//  SubviewTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockTitleView.h"

@implementation HYBlockTitleView

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

- (UIButton *)arrowButton {

    if (!_arrowButton) {
        _arrowButton = [UIButton new];
    }
    return _arrowButton;
}

- (UIButton *)moreButton {

    if (!_moreButton) {
        _moreButton = [UIButton new];
    }
    return _moreButton;
}

- (UILabel *)titleLabel {

    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;
}


- (void)setupSubviews {
    self.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.arrowButton];
    [self addSubview:self.moreButton];
    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat titleLabelX = 0;
    CGFloat titleLabelY = 0;
    CGFloat titleLabelW = self.frame.size.width;
    CGFloat titleLabelH = self.frame.size.height;
    _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    CGFloat arrowButtonY = 0;
    CGFloat arrowButtonW = 22;
    CGFloat arrowButtonX = titleLabelW - 15 - arrowButtonW;
    CGFloat arrowButtonH = titleLabelH;
    _arrowButton.frame = CGRectMake(arrowButtonX, arrowButtonY, arrowButtonW, arrowButtonH);

    CGFloat moreButtonW = 35;
    CGFloat moreButtonX = arrowButtonX - moreButtonW;
    CGFloat moreButtonY = 0;
    CGFloat moreButtonH = titleLabelH;
    _moreButton.frame = CGRectMake(moreButtonX, moreButtonY, moreButtonW, moreButtonH);

}


@end
