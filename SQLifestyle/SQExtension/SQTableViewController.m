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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQTableViewSection * sections = self.dataSource[indexPath.section];
    SQTableViewRow * rows = sections.rows[indexPath.row];
    SQTableViewCell * cell = [rows.tableViewCell cellWithTableView:tableView];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SQTableViewSection * sections = self.dataSource[indexPath.section];
    SQTableViewRow * rows = sections.rows[indexPath.row];
    [self.navigationController pushViewController:[rows.nextViewController new] animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SQTableViewSection * sections = self.dataSource[section];
    SQHeaderFooterView * headerView = [sections.headerView viewWithTableView:tableView];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    SQTableViewSection * sections = self.dataSource[section];
    SQHeaderFooterView * footerView = [sections.footerView viewWithTableView:tableView];
    return footerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    SQTableViewSection * sections = self.dataSource[section];
    return sections.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    SQTableViewSection * sections = self.dataSource[section];
    return sections.footerTitle;
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

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
