//
//  SQTrainingDateListPresenter.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingDateListPresenter.h"
#import "SQTrainingDateListViewProtocol.h"
#import "SQTrainingDateListInteractorInput.h"
#import "SQViperWireframePrivate.h"

@interface SQTrainingDateListPresenter ()

@property (nonatomic, weak) id<SQTrainingDateListViewProtocol> view;
@property (nonatomic, strong) id<SQTrainingDateListInteractorInput> interactor;
@property (nonatomic, strong) id<SQViperWireframePrivate> wireframe;

@end

@implementation SQTrainingDateListPresenter

- (void)handleViewReady {
    NSAssert(self.wireframe, @"Router should be initlized when view is ready.");
    NSAssert([self.view conformsToProtocol:@protocol(SQViperView)], @"Presenter should be attach to a view");
    NSAssert([self.interactor conformsToProtocol:@protocol(SQViperInteractor)], @"Interactor should be initlized when view is ready.");
    [self.interactor loadDataSourceWithType:self.view.type];
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
}


- (void)didTouchNavigationBarAddButton {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString *traningDate = [dateFormatter stringFromDate:date];
    NSMutableArray *dataSource = [NSMutableArray arrayWithArray:self.fetchDataSourceFromDB];
    if ([traningDate isEqualToString:dataSource.firstObject]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Cannot add training repeatedly" preferredStyle:(UIAlertControllerStyleAlert)];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:(UIAlertActionStyleCancel) handler:nil]];
        [self.wireframe.router.class presentViewController:alert fromViewController:self.view.routeSource animated:YES completion:nil];
        return;
    }
    [dataSource insertObject:[dateFormatter stringFromDate:date] atIndex:0];
    __weak typeof(self) _self = self;
    [self.interactor storeDataSourceWithType:self.view.type dataSource:dataSource completion:^{
        [_self.interactor loadDataSourceWithType:self.view.type];
        [_self.view setupUI];
    }];
    
//    [self performSegueWithIdentifier:@"TrainCapacity" sender:nil];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.dataBase.dateList = self.dataSource;
//        [SQSqliteModelTool saveOrUpdateModel:self.dataBase uid:nil];
//    });
}

- (nonnull NSArray *)fetchDataSourceFromDB {
    return [self.interactor fetchDataSource];
}

@end
