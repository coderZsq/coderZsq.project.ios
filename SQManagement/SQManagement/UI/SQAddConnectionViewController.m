//
//  SQAddConnectionViewController.m
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/24.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQAddConnectionViewController.h"
#import "SQProfileHeaderView.h"
#import "SQConnectionPropertyCell.h"

@interface SQAddConnectionViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation SQAddConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增人脉";
    self.dataSource = @[@"姓名", @"角色", @"职业", @"地区", @"行业", @"影响力", @"亲密程度", @"黄金人脉圈"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SQConnectionPropertyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SQConnectionPropertyCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQConnectionPropertyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SQConnectionPropertyCell class])];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [SQProfileHeaderView headerView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

- (IBAction)doneButtonClick:(UIBarButtonItem *)sender {
    [self dismiss];
}

- (IBAction)cancelButtonClick:(UIBarButtonItem *)sender {
    [self dismiss];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
