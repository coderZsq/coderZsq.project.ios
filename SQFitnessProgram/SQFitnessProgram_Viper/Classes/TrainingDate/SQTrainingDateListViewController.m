//
//  SQTrainingDateListViewController.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2018/12/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTrainingDateListViewController.h"
#import "SQTrainingDateListDataBase.h"
#import "SQSqliteModelTool.h"

@interface SQTrainingDateListViewController ()
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) SQTrainingDateListDataBase * dataBase;
@end

@implementation SQTrainingDateListViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (SQTrainingDateListDataBase *)dataBase {
    if (!_dataBase) {
        _dataBase = [SQTrainingDateListDataBase new];
    }
    return _dataBase;
}

- (void)setType:(SQTrainingCapacityMuscleType)type {
    _type = type;
    self.dataBase.type = type;
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

- (void)setupData {
    SQTrainingDateListDataBase * dataBase = [SQSqliteModelTool queryModels:self.dataBase.class columnName:@"type" relation:(ColumnNameToValueRelationTypeEqual) value:@(self.type) uid:nil].firstObject;
    [self.dataSource addObjectsFromArray:dataBase.dateList];
}

- (IBAction)addTraningDate:(UIBarButtonItem *)sender {
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString * traningDate = [dateFormatter stringFromDate:date];
    if ([traningDate isEqualToString:self.dataSource.firstObject]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"Cannot add training repeatedly" preferredStyle:(UIAlertControllerStyleAlert)];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:(UIAlertActionStyleCancel) handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    [self.dataSource insertObject:[dateFormatter stringFromDate:date] atIndex:0];
    [self.tableView reloadData];
    [self performSegueWithIdentifier:@"TrainCapacity" sender:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.dataBase.dateList = self.dataSource;
        [SQSqliteModelTool saveOrUpdateModel:self.dataBase uid:nil];
    });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender {
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString * traningDate = [dateFormatter stringFromDate:date];
    UIViewController * vc = segue.destinationViewController;
    NSString * title = [NSString stringWithFormat:@"Training Date: %@", sender ? sender.textLabel.text : traningDate];
    [vc setValue:title forKey:@"title"];
    [vc setValue:@(self.type) forKey:@"type"];
}

@end
