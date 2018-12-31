//
//  SQTrainingCapacityViewController.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2018/12/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTrainingCapacityViewController.h"
#import "SQTrainingCapacityCell.h"
#import "SQTrainingCapacityHeaderView.h"
#import "SQTrainingCapacityFooterView.h"

@interface SQTrainingCapacityViewController ()
@property (nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation SQTrainingCapacityViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)setupUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addTraningAction)];
    [self addTraningAction];
    self.tableView.tableHeaderView = [SQTrainingCapacityHeaderView headerView];
    self.tableView.tableFooterView = [SQTrainingCapacityFooterView footerView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SQTrainingCapacityCell" bundle:[NSBundle bundleForClass:self.class]] forCellReuseIdentifier:@"TrainingCapacity"];
    [self setupDataSource:self.dataSource loadCell:^UITableViewCell *(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return [tableView dequeueReusableCellWithIdentifier:@"TrainingCapacity" forIndexPath:indexPath];
    } loadCellHeight:^CGFloat(id  _Nonnull model) {
        return 160;
    } bind:^(UITableViewCell * _Nonnull cell, id  _Nonnull model) {
        
    }];
}

- (void)addTraningAction {
    [self.dataSource addObject:@"1"];
    [self.tableView reloadData];
}

@end
