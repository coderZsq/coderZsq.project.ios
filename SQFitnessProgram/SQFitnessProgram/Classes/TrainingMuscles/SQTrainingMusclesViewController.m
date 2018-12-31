//
//  SQTrainingMusclesViewController.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2018/12/31.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTrainingMusclesViewController.h"

@interface SQTrainingMusclesViewController ()

@end

@implementation SQTrainingMusclesViewController

- (void)setupUI {
    self.title = @"Training Muscle Group";
    NSArray * dataSource = @[@"Pectoral muscle",
                             @"Back muscle",
                             @"Leg muscle",
                             @"Shoulder muscle",
                             @"Arm muscle",
                             @"Abdominal muscle"];
    [self setupDataSource:dataSource loadCell:^UITableViewCell *(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return [tableView dequeueReusableCellWithIdentifier:@"TrainingMuscles" forIndexPath:indexPath];
    } loadCellHeight:^CGFloat(id  _Nonnull model) {
        return 44;
    } bind:^(UITableViewCell * _Nonnull cell, id  _Nonnull model) {
        cell.textLabel.text = model;
    }];
}

@end
