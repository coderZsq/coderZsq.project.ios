//
//  SQTableViewRow.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQTableViewRow.h"

@implementation SQTableViewRow

+ (instancetype)rowForTableViewCell:(Class)tableViewCell cellHeight:(double)cellHeight {
    
    SQTableViewRow * row = [SQTableViewRow new];
    row.tableViewCell = tableViewCell;
    row.cellHeight = cellHeight;
    return row;
}

@end
