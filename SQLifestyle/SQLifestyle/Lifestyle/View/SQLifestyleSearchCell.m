//
//  SQLifestyleSearchCell.m
//  SQLifestyle
//
//  Created by Doubles_Z on 16-6-24.
//  Copyright (c) 2016年 Doubles_Z. All rights reserved.
//

#import "SQLifestyleSearchCell.h"

@interface SQLifestyleSearchCell ()

@property (nonatomic,strong) UIImageView * hotSpotsImageView;

@end

@implementation SQLifestyleSearchCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * identifier = NSStringFromClass([SQLifestyleSearchCell class]);
    SQLifestyleSearchCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SQLifestyleSearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.userInteractionEnabled = NO;
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

- (UIImageView *)hotSpotsImageView {
    
    if (!_hotSpotsImageView) {
        _hotSpotsImageView = [UIImageView new];
        _hotSpotsImageView.image = [UIImage imageNamed:@"Hot Spots"];
    }
    return _hotSpotsImageView;
}

- (void)setupSubviews {
    [self setBackgroundColor:GLOBAL_BGC];
    [self.contentView addSubview:self.hotSpotsImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = kSpace;
    
    CGFloat hotSpotsImageViewX = padding;
    CGFloat hotSpotsImageViewW = 90;
    CGFloat hotSpotsImageViewH = 20;
    CGFloat hotSpotsImageViewY = self.height - hotSpotsImageViewH - 5;
    self.hotSpotsImageView.frame = CGRectMake(hotSpotsImageViewX, hotSpotsImageViewY, hotSpotsImageViewW, hotSpotsImageViewH);
}

+ (CGFloat)cellHeight {
	return 70;
}

@end
