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
#import "SQTrainingCapacityCellPresenter.h"
#import "SQTrainingCapacityDataSource.h"
#import "SQTrainingCapacityViewEventHandler.h"

@interface SQTrainingCapacityViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation SQTrainingCapacityViewController

- (void)setupData {
    _dataSource = [NSMutableArray array];
}

- (void)setupUI {
    [self setupRightBarButtonItem];
    [self setupTableViewContent];
    [self setupTableView];
}

- (void)setupRightBarButtonItem {
    [self setRightBarButtonItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addTraningAction)];
}

- (void)setRightBarButtonItem:(UIBarButtonSystemItem)item target:(nullable id)target action:(nullable SEL)action {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:item target:target action:action];
}

- (void)setupTableViewContent {
    self.tableView.tableHeaderView = [SQTrainingCapacityHeaderView headerView];
    SQTrainingCapacityFooterView * footerView = [SQTrainingCapacityFooterView footerView];
    footerView.totalCapacityLabel.text = [(id<SQTrainingCapacityDataSource>)self.viewDataSource totalCapacity];
    self.tableView.tableFooterView = footerView;
    self.footerView = footerView;
    [self.tableView registerNib:[UINib nibWithNibName:@"SQTrainingCapacityCell" bundle:[NSBundle bundleForClass:self.class]] forCellReuseIdentifier:@"TrainingCapacity"];
}

- (void)setupTableView {
    [self setupDataSource:self.dataSource loadCell:^UITableViewCell *(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return [tableView dequeueReusableCellWithIdentifier:@"TrainingCapacity" forIndexPath:indexPath];
    } loadCellHeight:^CGFloat(id  _Nonnull model) {
        return 160;
    } bind:^(UITableViewCell * _Nonnull cell, id  _Nonnull model) {
        SQTrainingCapacityCell * c = (SQTrainingCapacityCell *)cell;
        SQTrainingCapacityCellPresenter * p = (SQTrainingCapacityCellPresenter * )model;
        [p bindToCell:c];
    }];
}

- (void)fetchDataSource {
    NSArray *dataSource = [(id<SQTrainingCapacityDataSource>)self.viewDataSource fetchDataSourceFromDB];
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:dataSource];
}

- (void)addTraningAction {
    [(id<SQTrainingCapacityViewEventHandler>)self.eventHandler didTouchNavigationBarAddButton];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [(id<SQTrainingCapacityViewEventHandler>)self.eventHandler handleCommitEditingAtIndexPath:indexPath];
}

@end
