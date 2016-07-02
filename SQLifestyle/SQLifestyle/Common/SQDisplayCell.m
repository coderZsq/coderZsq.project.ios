//
//  SQDisplayCell.m
//  SQLifestyle
//
//  Created by Doubles_Z on 16-6-29.
//  Copyright (c) 2016年 Doubles_Z. All rights reserved.
//

#import "SQDisplayCell.h"

@implementation SQDisplayCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * identifier = NSStringFromClass([self class]);
    SQDisplayCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (UIImageView *)displayImageView {
    
    if (!_displayImageView) {
        _displayImageView = [UIImageView new];
        _displayImageView.contentMode = UIViewContentModeScaleAspectFill;
        _displayImageView.clipsToBounds = YES;
        _displayImageView.layer.borderColor = KC05_dddddd.CGColor;
        _displayImageView.layer.borderWidth = 0.5f;
        _displayImageView.image = [UIImage imageNamed:@"image 2"];
    }
    return _displayImageView;
}

- (UILabel *)displayTitleLabel {
    
    if (!_displayTitleLabel) {
        _displayTitleLabel = [UILabel new];
        _displayTitleLabel.textColor = KC02_2c2c2c;
        _displayTitleLabel.text = @"Ride Bicycle";
    }
    return _displayTitleLabel;
}

- (UILabel *)displayContentLabel {
    
    if (!_displayContentLabel) {
        _displayContentLabel = [UILabel new];
        _displayContentLabel.textColor = KC03_666666;
        _displayContentLabel.text = @"I’m riding on highway with my friend John That’s fantastic Awesome!!";
        _displayContentLabel.numberOfLines = 0;
    }
    return _displayContentLabel;
}

- (UILabel *)displayTimeLabel {
    
    if (!_displayTimeLabel) {
        _displayTimeLabel = [UILabel new];
        _displayTimeLabel.textColor = KC03_666666;
        _displayTimeLabel.text = @"06-29-2016";
    }
    return _displayTimeLabel;
}

- (UIView *)dividingLineView {
    
    if (!_dividingLineView) {
        _dividingLineView = [UIView new];
        _dividingLineView.backgroundColor = [UIColor lightGrayColor];
        _dividingLineView.alpha = 0.3f;
    }
    return _dividingLineView;
}

- (void)setupSubviews {
    [self.contentView addSubview:self.displayImageView];
    [self.contentView addSubview:self.displayTitleLabel];
    [self.contentView addSubview:self.displayContentLabel];
    [self.contentView addSubview:self.displayTimeLabel];
    [self.contentView addSubview:self.dividingLineView];
}

+ (CGFloat)cellHeight {
	return 0;
}

@end
