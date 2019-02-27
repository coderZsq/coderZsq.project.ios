//
//  SQTrainingDateListViewController.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2018/12/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTrainingDateListViewController.h"
#import "SQTrainingDateListViewEventHandler.h"
#import "SQTrainingDateListDataSource.h"

@interface SQTrainingDateListViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation SQTrainingDateListViewController

- (void)setupData {
    _dataSource = [NSMutableArray array];
}

- (void)fetchDataSource {
    NSArray *dataSource = [(id<SQTrainingDateListDataSource>)self.viewDataSource fetchDataSourceFromDB];
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:dataSource];
}

- (void)setupUI {
    self.title = @"Training Date";
    [self setupDataSource:self.dataSource loadCell:^UITableViewCell *(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return [tableView dequeueReusableCellWithIdentifier:@"TrainingDate" forIndexPath:indexPath];
    } loadCellHeight:^CGFloat(id  _Nonnull model) {
        return 44;
    } bind:^(UITableViewCell * _Nonnull cell, id  _Nonnull model) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", model];
    }];
}

- (IBAction)addTraningDate:(UIBarButtonItem *)sender {
    [(id<SQTrainingDateListViewEventHandler>)self.eventHandler didTouchNavigationBarAddButton];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [(id<SQTrainingDateListViewEventHandler>)self.eventHandler handleDidSelectRowAtIndexPath:indexPath];
}

@end
