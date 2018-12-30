//
//  SQTrainingDateListViewController.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2018/12/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTrainingDateListViewController.h"

@interface SQTrainingDateListViewController ()
@property (nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation SQTrainingDateListViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString * traningDate = [dateFormatter stringFromDate:date];
    if ([traningDate isEqualToString:self.dataSource.lastObject]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"Cannot add training repeatedly" preferredStyle:(UIAlertControllerStyleAlert)];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:(UIAlertActionStyleCancel) handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    [self.dataSource addObject:[dateFormatter stringFromDate:date]];
    [self.tableView reloadData];
    [self performSegueWithIdentifier:@"TrainCapacity" sender:nil];
}

@end
