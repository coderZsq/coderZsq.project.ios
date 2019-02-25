//
//  SQTrainingMusclesBuilder.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingMusclesBuilder.h"
#import "SQTrainingMusclesViewController.h"
#import "SQTrainingMusclesPresenter.h"
#import "SQTrainingMusclesInteractor.h"
#import "SQTrainingMusclesWireframe.h"

@implementation SQTrainingMusclesBuilder

+ (UIViewController *)viewControllerWithTrainingMusclesDataService:(id<SQTrainingMusclesDataService>)service router:(id<SQViperRouter>)router {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:self.class]];
    UIViewController *view = [sb instantiateViewControllerWithIdentifier:@"SQTrainingMusclesViewController"];
    NSAssert([view isKindOfClass:[SQTrainingMusclesViewController class]], nil);
    [self buildView:(id<SQViperViewPrivate>)view trainingMusclesDataService:service router:router];
    return view;
}

+ (void)buildView:(id<SQViperViewPrivate>)view trainingMusclesDataService:(id<SQTrainingMusclesDataService>)service router:(id<SQViperRouter>)router {
    
    NSParameterAssert([view isKindOfClass:[SQTrainingMusclesViewController class]]);
    NSParameterAssert(service);
    
    SQTrainingMusclesPresenter *presenter = [SQTrainingMusclesPresenter new];
    SQTrainingMusclesInteractor *interactor = [[SQTrainingMusclesInteractor alloc]initWithTrainingMusclesDataService:service];
    
    interactor.eventHandler = presenter;
    interactor.dataSource = presenter;
    
    id<SQViperWireframePrivate> wireframe = (id)[SQTrainingMusclesWireframe new];
    wireframe.view = view;
    wireframe.router = router;
    
    [(id<SQViperPresenterPrivate>)presenter setView:view];
    [(id<SQViperPresenterPrivate>)presenter setWireframe:wireframe];
    [(id<SQViperPresenterPrivate>)presenter setInteractor:interactor];
    
    view.eventHandler = presenter;
    view.viewDataSource = presenter;
}

@end
