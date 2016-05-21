//
//  SQScaleImageView.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface SQScaleImageView : UIImageView

@property (nonatomic,strong) UITableView * tableView;

- (void)scaleWithScrollViewContentOffset:(CGPoint)contentOffset;

@end
