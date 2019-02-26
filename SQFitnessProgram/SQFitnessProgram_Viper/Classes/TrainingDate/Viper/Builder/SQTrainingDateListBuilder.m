//
//  SQTrainingDateListBuilder.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingDateListBuilder.h"
#import "SQTrainingDateListViewController.h"
#import "SQTrainingDateListPresenter.h"
#import "SQTrainingDateListInteractor.h"
#import "SQTrainingDateListWireframe.h"
#import "SQTrainingDateListDataManager.h"
#import "NSObject+SQViperAssembly.h"

@implementation SQTrainingDateListBuilder

+ (UIViewController *)viewControllerForTrainingDateListWithType:(SQTrainingCapacityMuscleType)type router:(id<SQViperRouter>)router {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:self.class]];
    SQTrainingDateListViewController *view = [sb instantiateViewControllerWithIdentifier:@"SQTrainingDateListViewController"];
    NSAssert([view isKindOfClass:[SQTrainingDateListViewController class]], nil);
    view.type = type;
    [self buildView:(id<SQViperViewPrivate>)view trainingDateListDataService:[SQTrainingDateListDataManager new] router:router];
    return view;
}

+ (void)buildView:(id<SQViperViewPrivate>)view trainingDateListDataService:(id<SQTrainingDateListDataService>)service router:(id<SQViperRouter>)router {
    id<SQViperPresenterPrivate> presenter = (id)[SQTrainingDateListPresenter new];
    id<SQViperInteractorPrivate> interactor = [(id)[SQTrainingDateListInteractor alloc]initWithTrainingDateListDataService:service];
    id<SQViperWireframePrivate> wireframe = (id)[SQTrainingDateListWireframe new];
    [self assembleViperForView:view
                     presenter:presenter
                    interactor:interactor
                     wireframe:wireframe
                        router:router];
}

@end
