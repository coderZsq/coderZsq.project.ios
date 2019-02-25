//
//  SQBaseTableViewController.h
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2018/12/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQViperView.h"

NS_ASSUME_NONNULL_BEGIN

typedef UITableViewCell *(^LoadCellType)(UITableView * tableView, NSIndexPath * indexPath);
typedef CGFloat(^LoadCellHType)(id model);
typedef void(^BindType)(UITableViewCell * cell, id model);

@interface SQBaseTableViewController : UITableViewController<SQViperView>

- (void)setupDataSource:(NSArray *)models
               loadCell:(LoadCellType)loadCell
         loadCellHeight:(LoadCellHType)loadCellHeight
                   bind:(BindType)bind;

@end

NS_ASSUME_NONNULL_END
