//
//  TableViewCellTemplate.h
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "<#Unit#>CellAdapter.h"

@interface <#Unit#>Cell : UITableViewCell

@property (nonatomic,strong) id<<#Unit#>CellAdapter> adapter;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (CGFloat)cellHeight;

@end
