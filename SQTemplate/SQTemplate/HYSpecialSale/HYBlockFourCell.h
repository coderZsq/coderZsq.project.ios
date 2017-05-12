//
//  TableViewCellTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBlockFourCellAdapter.h"

@interface HYBlockFourCell : UITableViewCell

@property (nonatomic,strong) id<HYBlockFourCellAdapter> adapter;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;

@end
