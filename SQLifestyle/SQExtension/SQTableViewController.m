//
//  SQTableViewController.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQTableViewController.h"

@interface SQTableViewController ()

@end

@implementation SQTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [SQViewControllerManager shareInstance].currentViewController = self;
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [@[] mutableCopy];
    }
    return _dataSource;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SQTableViewSection * sections = self.dataSource[section];
    return sections.rows.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQTableViewSection * sections = self.dataSource[indexPath.section];
    SQTableViewRow * rows = sections.rows[indexPath.row];
    return rows.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SQTableViewSection * sections = self.dataSource[section];
    return sections.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    SQTableViewSection * sections = self.dataSource[section];
    return  sections.footerHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    SQTableViewSection * sections = self.dataSource[section];
    return sections.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    SQTableViewSection * sections = self.dataSource[section];
    return sections.footerTitle;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
