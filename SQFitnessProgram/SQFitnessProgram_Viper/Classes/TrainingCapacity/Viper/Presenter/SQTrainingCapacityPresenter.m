//
//  SQTrainingCapacityPresenter.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingCapacityPresenter.h"
#import "SQTrainingCapacityViewProtocol.h"
#import "SQTrainingCapacityInteractorInput.h"
#import "SQTrainingCapacityWireframeInput.h"
#import "SQTrainingCapacityNotification.h"

@interface SQTrainingCapacityPresenter ()

@property (nonatomic, weak) id<SQTrainingCapacityViewProtocol> view;
@property (nonatomic, strong) id<SQTrainingCapacityInteractorInput> interactor;
@property (nonatomic, strong) id<SQTrainingCapacityWireframeInput> wireframe;

@end

@implementation SQTrainingCapacityPresenter

- (void)handleViewReady {
    NSAssert(self.wireframe, @"Router should be initlized when view is ready.");
    NSAssert([self.view conformsToProtocol:@protocol(SQViperView)], @"Presenter should be attach to a view");
    NSAssert([self.interactor conformsToProtocol:@protocol(SQViperInteractor)], @"Interactor should be initlized when view is ready.");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.interactor loadDataSourceWithTitle:self.view.title type:self.view.type];
}

- (void)handleViewWillAppear:(BOOL)animated {
    NSLog(@"%s", __func__);
}

- (void)handleViewDidAppear:(BOOL)animated {
    NSLog(@"%s", __func__);
}

- (void)handleViewWillDisappear:(BOOL)animated {
    NSLog(@"%s", __func__);
}

- (void)handleViewDidDisappear:(BOOL)animated {
    NSLog(@"%s", __func__);
}

- (void)handleViewRemoved {
    NSLog(@"%s", __func__);
    [self.interactor storeDataSourceWithTitle:self.view.title type:self.view.type dataSource:self.fetchDataSourceFromDB];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSString *)totalCapacity {
    return self.interactor.totalCapacity;
}

- (NSArray *)fetchDataSourceFromDB {
    return [self.interactor fetchDataSource];
}

- (void)didTouchNavigationBarAddButton {
    __weak typeof(self) _self = self;
    [self.interactor addTrainingActionWithCompletion:^{
        [_self.view setupTableView];
    }];
}

- (void)keyboardWillShow:(NSNotification *)sender {
    [self.view setRightBarButtonItem:(UIBarButtonSystemItemDone) target:self action:@selector(doneAction)];
}

- (void)keyboardWillHide:(NSNotification *)sender {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.view setRightBarButtonItem:(UIBarButtonSystemItemAdd) target:self.view action:@selector(addTraningAction)];
#pragma clang diagnostic pop
}

- (void)doneAction {
    [self.view.tableView endEditing:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:SQTrainingCapacityBindToModelNotification object:nil];
    self.view.footerView.totalCapacityLabel.text = self.totalCapacity;
    [self.view.tableView reloadData];
}

@end
