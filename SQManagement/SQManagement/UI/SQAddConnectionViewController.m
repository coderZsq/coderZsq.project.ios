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
#import "UIColor+SQExtension.h"

@interface SQAddConnectionViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation SQAddConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增人脉";
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
    self.dataSource = @[
        @[@"姓名",
          @"角色",
          @"职业",
          @"地区",
          @"行业",
          @"影响力",
          @"亲密程度",
          @"黄金人脉圈"],
        @[@"联系方式",
          @"社交记录"],
        @[@"特征",
          @"工作",
          @"爱好",
          @"特殊细节",
          @"给我的启发"],
    ];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SQConnectionPropertyCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SQConnectionPropertyCell class])];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rows = self.dataSource[section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQConnectionPropertyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SQConnectionPropertyCell class])];
    cell.titleLabel.text = self.dataSource[indexPath.section][indexPath.row];
    if (indexPath.section != 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.contentTextField.hidden = YES;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentTextField.hidden = NO;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) return [SQProfileHeaderView headerView];
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 100;
    return 1;
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
