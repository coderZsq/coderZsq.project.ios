//
//  SQDisplayCell.h
//  SQLifestyle
//
//  Created by Doubles_Z on 16-6-29.
//  Copyright (c) 2016年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQDisplayCell : UITableViewCell

@property (nonatomic,strong) UIImageView * displayImageView;
@property (nonatomic,strong) UILabel     * displayTitleLabel;
@property (nonatomic,strong) UILabel     * displayContentLabel;
@property (nonatomic,strong) UILabel     * displayTimeLabel;
@property (nonatomic,strong) UIView      * dividingLineView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;

- (void)setupSubviews;

@end
