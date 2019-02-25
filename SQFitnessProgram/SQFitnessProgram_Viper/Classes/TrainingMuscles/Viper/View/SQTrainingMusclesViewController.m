//
//  SQTrainingMusclesViewController.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2018/12/31.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTrainingMusclesViewController.h"
#import "SQTrainingCapacityMuscleType.h"
#import "SQTrainingMusclesViewEventHandler.h"
#import "SQTrainingMusclesDataSource.h"
#import "UIViewController+SQViperRouter.h"

@interface SQTrainingMusclesViewController ()

@property (nonatomic, assign) BOOL appeared;
@property (nonatomic, strong) id<SQTrainingMusclesViewEventHandler> eventHandler;
@property (nonatomic, strong) id<SQTrainingMusclesDataSource> viewDataSource;

@end

@implementation SQTrainingMusclesViewController

- (UIViewController *)routeSource {
    return self;
}

- (void)viewDidLoad {
    if (self.appeared == NO) {
        NSAssert([self.eventHandler conformsToProtocol:@protocol(SQTrainingMusclesViewEventHandler)], nil);
        if ([self.eventHandler respondsToSelector:@selector(handleViewReady)]) {
            [self.eventHandler handleViewReady];
        }
        [super viewDidLoad];
        self.appeared = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewWillAppear:)]) {
        [self.eventHandler handleViewWillAppear:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewDidAppear:)]) {
        [self.eventHandler handleViewDidAppear:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewDidDisappear:)]) {
        [self.eventHandler handleViewDidDisappear:animated];
    }
    if (self.SQ_isRemoving == YES) {
        if ([self.eventHandler respondsToSelector:@selector(handleViewRemoved)]) {
            [self.eventHandler handleViewRemoved];
        }
    }
}

- (void)setupUI {
    self.title = @"Training Muscle Group";
    NSArray * dataSource = [self.viewDataSource fetchDataSource];
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
    [self.eventHandler handleDidSelectRowAtIndexPath:indexPath];
}

@end
