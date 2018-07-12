//
//  ComponentCell.h
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "AsyncDrawCell.h"

@class ComponentLayout;
@interface ComponentCell : AsyncDrawCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setupData:(ComponentLayout *)layout asynchronously:(BOOL)asynchronously;

@end
