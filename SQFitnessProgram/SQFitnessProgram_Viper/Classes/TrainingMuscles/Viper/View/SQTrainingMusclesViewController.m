//
//  SQTrainingMusclesViewController.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2018/12/31.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTrainingMusclesViewController.h"
#import "SQTrainingMusclesViewEventHandler.h"
#import "SQTrainingMusclesDataSource.h"

@implementation SQTrainingMusclesViewController

- (void)setupUI {
    self.title = @"Training Muscle Group";
    NSArray *dataSource = [(id<SQTrainingMusclesDataSource>)self.viewDataSource fetchDataSource];
    [self setupDataSource:dataSource loadCell:^UITableViewCell *(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
        return [tableView dequeueReusableCellWithIdentifier:@"TrainingMuscles" forIndexPath:indexPath];
    } loadCellHeight:^CGFloat(id  _Nonnull model) {
        return 44;
    } bind:^(UITableViewCell * _Nonnull cell, id  _Nonnull model) {
        cell.textLabel.text = model;
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [(id<SQTrainingMusclesViewEventHandler>)self.eventHandler handleDidSelectRowAtIndexPath:indexPath];
}

@end
