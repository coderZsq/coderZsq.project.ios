//
//  SQTrainingDateListPresenter.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingDateListPresenter.h"
#import "SQViperViewPrivate.h"
#import "SQViperInteractorPrivate.h"
#import "SQViperWireframePrivate.h"

@interface SQTrainingDateListPresenter ()

@property (nonatomic, weak) id<SQViperViewPrivate> view;
@property (nonatomic, weak) id<SQViperInteractorPrivate> interactor;
@property (nonatomic, weak) id<SQViperWireframePrivate> wireframe;

@end

@implementation SQTrainingDateListPresenter

- (void)handleViewReady {
    
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


@end
