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
#import "SQTrainingCapacityDataBase.h"
#import "SQSqliteModelTool.h"

@interface SQTrainingCapacityViewController ()
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, copy) NSString * totalCapacity;
@property (nonatomic, strong) SQTrainingCapacityDataBase * dataBase;
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

- (SQTrainingCapacityDataBase *)dataBase {
    if (!_dataBase) {
        _dataBase = [SQTrainingCapacityDataBase new];
    }
    return _dataBase;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self saveData];
}

- (void)setupUI {
    [self setRightBarButtonItem:(UIBarButtonSystemItemAdd) action:@selector(addTraningAction)];
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
    if (self.totalCapacity.length) {
        footerView.totalCapacityLabel.text = self.totalCapacity;
    }
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
    SQTrainingCapacityDataBase * dataBase = [SQSqliteModelTool queryModels:self.dataBase.class columnName:@"key" relation:(ColumnNameToValueRelationTypeEqual) value:[NSString stringWithFormat:@"%ld-%@", self.type, self.title] uid:nil].firstObject;
    if (!dataBase) {
        [self addTraningAction];
        return;
    }
    NSMutableArray * dataSource = [NSMutableArray array];
    NSInteger totalCapacity = 0;
    for (NSDictionary * d in dataBase.dataSource) {
        SQTrainingCapacityCellPresenter * p = [SQTrainingCapacityCellPresenter new];
        SQTrainingCapacityModel * m = [SQTrainingCapacityModel new];
        p.model = m;
        NSMutableArray * rows = [NSMutableArray array];
        for (NSDictionary * dr in d[@"rows"]) {
            SQTrainingCapacityRowModel * rm = [SQTrainingCapacityRowModel new];
            rm.groups = [dr[@"groups"] integerValue];
            rm.times = [dr[@"times"] integerValue];
            rm.weight = [dr[@"weight"] integerValue];
            [rows addObject:rm];
        }
        p.model.rows = rows;
        totalCapacity += p.model.capacity = [d[@"capacity"] integerValue];
        [dataSource addObject:p];
    }
    self.dataSource = dataSource;
    self.totalCapacity = [NSString stringWithFormat:@"%ld", totalCapacity];
}

- (void)saveData {
    self.dataBase.key = [NSString stringWithFormat:@"%ld-%@", self.type, self.title];
    self.dataBase.type = self.type;
    self.dataBase.date = self.title;
    NSMutableArray * dataSource = [NSMutableArray array];
    for (SQTrainingCapacityCellPresenter * p in self.dataSource) {
        NSMutableDictionary * md = [NSMutableDictionary dictionary];
        md[@"capacity"] = @(p.model.capacity);
        NSMutableArray * ma = [NSMutableArray array];
        for (SQTrainingCapacityRowModel * rm in p.model.rows) {
            NSMutableDictionary * mdr = [NSMutableDictionary dictionary];
            mdr[@"groups"] = @(rm.groups);
            mdr[@"times"] = @(rm.times);
            mdr[@"weight"] = @(rm.weight);
            [ma addObject:mdr];
        }
        md[@"rows"] = ma;
        [dataSource addObject:md];
    }
    self.dataBase.dataSource = dataSource;
    [SQSqliteModelTool saveOrUpdateModel:self.dataBase uid:nil];
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
