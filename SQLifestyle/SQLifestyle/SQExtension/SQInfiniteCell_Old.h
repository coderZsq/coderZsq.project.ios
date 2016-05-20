//
//  SQInfiniteCell_Old.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQInfiniteCell_Old : UITableViewCell

@property (nonatomic,strong) NSArray * infiniteLoopData;

@property (nonatomic,assign) NSTimeInterval timeInterval;

@property (nonatomic,strong) UIColor * pageIndicatorTintColor;

@property (nonatomic,strong) UIColor * currentPageIndicatorTintColor;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
