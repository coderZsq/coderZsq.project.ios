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
#import "SQTrainingCapacityNotification.h"

@interface SQTrainingCapacityViewController ()
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, weak) SQTrainingCapacityFooterView * footerView;
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
    [self setRightBarButtonItem:(UIBarButtonSystemItemAdd) action:@selector(addTraningAction)];
    [self addTraningAction];
    [self setTableViewConfig];
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

- (void)setTableViewConfig {
    self.tableView.tableHeaderView = [SQTrainingCapacityHeaderView headerView];
    SQTrainingCapacityFooterView * footerView = [SQTrainingCapacityFooterView footerView];
    self.tableView.tableFooterView = footerView;
    self.footerView = footerView;
    [self.tableView registerNib:[UINib nibWithNibName:@"SQTrainingCapacityCell" bundle:[NSBundle bundleForClass:self.class]] forCellReuseIdentifier:@"TrainingCapacity"];
}

- (void)setRightBarButtonItem:(UIBarButtonSystemItem)item action:(nullable SEL)action {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:item target:self action:action];
}

- (void)setupData {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)addTraningAction {
    SQTrainingCapacityCellPresenter * p = [SQTrainingCapacityCellPresenter new];
    p.model = [SQTrainingCapacityModel new];
    [self.dataSource addObject:p];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0]] withRowAnimation:(UITableViewRowAnimationLeft)];
}

- (void)doneAction {
    [self.tableView endEditing:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:SQTrainingCapacityBindToModelNotification object:nil];
    [self calculateTotalCapacity];
    [self.tableView reloadData];
}

- (void)calculateTotalCapacity {
    NSInteger totalCapacity = 0;
    for (SQTrainingCapacityCellPresenter * p in self.dataSource) {
        totalCapacity += p.model.capacity;
    }
    self.footerView.totalCapacityLabel.text = [NSString stringWithFormat:@"%ld", totalCapacity];
}

- (void)keyboardWillShow:(NSNotification *)sender {
    [self setRightBarButtonItem:(UIBarButtonSystemItemDone) action:@selector(doneAction)];
}

- (void)keyboardWillHide:(NSNotification *)sender {
    [self setRightBarButtonItem:(UIBarButtonSystemItemAdd) action:@selector(addTraningAction)];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataSource removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self calculateTotalCapacity];
}

@end
