//
//  SQLifestyleDisplayCell.m
//  SQLifestyle
//
//  Created by Doubles_Z on 16-6-29.
//  Copyright (c) 2016年 Doubles_Z. All rights reserved.
//

#import "SQLifestyleDisplayCell.h"

@implementation SQLifestyleDisplayCell

- (void)setupSubviews {
    [super setupSubviews];
    self.displayTitleLabel.font = KF04_15px;
    self.displayContentLabel.numberOfLines = 2;
    self.displayContentLabel.font = KF05_14px;
    self.displayTimeLabel.textAlignment = NSTextAlignmentRight;
    self.displayTimeLabel.font = KF05_14px;
    self.backgroundColor = GLOBAL_BGC;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = kSpace;
    
    CGFloat displayImageViewX = padding;
    CGFloat displayImageViewW = 60;
    CGFloat displayImageViewH = displayImageViewW;
    CGFloat displayImageViewY = (self.height - displayImageViewH) * 0.5f;
    self.displayImageView.frame = CGRectMake(displayImageViewX, displayImageViewY, displayImageViewW, displayImageViewH);
    
    CGFloat displayTitleLabelX = displayImageViewX + displayImageViewW + padding;
    CGFloat displayTitleLabelY = displayImageViewY;
    CGFloat displayTitleLabelW = (self.width - displayTitleLabelX - padding) * 0.5f;
    CGFloat displayTitleLabelH = displayImageViewH * 0.4f;
    self.displayTitleLabel.frame = CGRectMake(displayTitleLabelX, displayTitleLabelY, displayTitleLabelW, displayTitleLabelH);
    
    CGFloat displayContentLabelX = displayTitleLabelX;
    CGFloat displayContentLabelY = displayTitleLabelY + displayTitleLabelH;
    CGFloat displayContentLabelW = displayTitleLabelW * 2;
    CGFloat displayContentLabelH = displayImageViewH - displayTitleLabelH;
    self.displayContentLabel.frame = CGRectMake(displayContentLabelX, displayContentLabelY, displayContentLabelW, displayContentLabelH);
    
    CGFloat displayTimeLabelY = displayTitleLabelY;
    CGFloat displayTimeLabelW = displayTitleLabelW;
    CGFloat displayTimeLabelH = displayTitleLabelH;
    CGFloat displayTimeLabelX = self.width - displayTimeLabelW - padding;
    self.displayTimeLabel.frame = CGRectMake(displayTimeLabelX, displayTimeLabelY, displayTimeLabelW, displayTimeLabelH);
    
    CGFloat dividingLineViewX = padding;
    CGFloat dividingLineViewW = self.width - 2 * padding;
    CGFloat dividingLineViewH = 0.5f;
    CGFloat dividingLineViewY = self.height - dividingLineViewH;
    self.dividingLineView.frame = CGRectMake(dividingLineViewX, dividingLineViewY, dividingLineViewW, dividingLineViewH);
}

+ (CGFloat)cellHeight {
    return 80;
}

@end
