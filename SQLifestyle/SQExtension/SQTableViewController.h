//
//  SQTableViewController.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQTableViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray * dataSource;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

