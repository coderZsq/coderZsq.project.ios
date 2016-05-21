//
//  SQInfiniteCell.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQInfiniteCell : UITableViewCell

@property (nonatomic,strong) NSMutableArray * dataSource;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
