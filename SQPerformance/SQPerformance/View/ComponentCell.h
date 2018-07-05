//
//  ComponentCell.h
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComponentLayout;
@interface ComponentCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setupData:(ComponentLayout *)layout;

@end
