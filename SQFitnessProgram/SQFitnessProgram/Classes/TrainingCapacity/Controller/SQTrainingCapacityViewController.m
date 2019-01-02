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
#import "SQTrainingCapacityModel.h"
#import "SQTrainingCapacityCellPresenter.h"

@interface SQTrainingCapacityViewController ()
@property (nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation SQTrainingCapacityViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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
    __weak typeof(self) _self = self;
    [self setupDataSource:self.dataSource loadCell:^UITableViewCell *(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return [tableView dequeueReusableCellWithIdentifier:@"TrainingCapacity" forIndexPath:indexPath];
    } loadCellHeight:^CGFloat(id  _Nonnull model) {
        return 160;
    } bind:^(UITableViewCell * _Nonnull cell, id  _Nonnull model) {
        SQTrainingCapacityCell * c = (SQTrainingCapacityCell *)cell;
        SQTrainingCapacityCellPresenter * p = (SQTrainingCapacityCellPresenter * )model;
        p.model.action = [NSString stringWithFormat:@"%ld", [_self.dataSource indexOfObject:model] + 1];
        [p bindToCell:c];
    }];
}

- (void)setupData {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)addTraningAction {
    SQTrainingCapacityCellPresenter * p = [SQTrainingCapacityCellPresenter new];
    p.model = [SQTrainingCapacityModel new];
    [self.dataSource addObject:p];
    [self.tableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES];
}

- (void)keyboardWillHide:(NSNotification *)sender {
    
}

@end
