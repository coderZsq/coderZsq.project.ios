//
//  SubviewTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "SubviewTemplate.h"

@implementation SubviewTemplate

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

- (UILabel *)textLabel {
    
    if (!_textLabel) {
        _textLabel = [UILabel new];
    }
    return _textLabel;
}

- (UILabel *)detailTextLabel {
    
    if (!_detailTextLabel) {
        _detailTextLabel = [UILabel new];
    }
    return _detailTextLabel;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (void)setupSubviews {
    [self addSubview:self.textLabel];
    [self addSubview:self.detailTextLabel];
    [self addSubview:self.imageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imageViewX = 10;
    CGFloat imageViewY = 10;
    CGFloat imageViewH = self.frame.size.height - (2 * imageViewY);
    CGFloat imageViewW = imageViewH;
    _imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    
    CGFloat textLabelX = imageViewX + imageViewW + 10;
    CGFloat textLabelY = 0;
    CGFloat textLabelW = self.frame.size.width - imageViewW;
    CGFloat textLabelH = self.frame.size.height / 2;
    _textLabel.frame = CGRectMake(textLabelX, textLabelY, textLabelW, textLabelH);
    
    CGFloat detailTextLabelX = textLabelX;
    CGFloat detailTextLabelY = textLabelY + textLabelH;
    CGFloat detailTextLabelW = textLabelW;
    CGFloat detailTextLabelH = textLabelH;
    _detailTextLabel.frame = CGRectMake(detailTextLabelX, detailTextLabelY, detailTextLabelW, detailTextLabelH);
}


@end
