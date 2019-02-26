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
#import "NSObject+SQViperAssembly.h"

@implementation SQTrainingMusclesBuilder

+ (UIViewController *)viewControllerWithTrainingMusclesDataService:(id<SQTrainingMusclesDataService>)service router:(id<SQViperRouter>)router {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:self.class]];
    UIViewController *view = [sb instantiateViewControllerWithIdentifier:@"SQTrainingMusclesViewController"];
    NSAssert([view isKindOfClass:[SQTrainingMusclesViewController class]], nil);
    [self buildView:(id<SQViperViewPrivate>)view trainingMusclesDataService:service router:router];
    return view;
}

+ (void)buildView:(id<SQViperViewPrivate>)view trainingMusclesDataService:(id<SQTrainingMusclesDataService>)service router:(id<SQViperRouter>)router {
    id<SQViperPresenterPrivate> presenter = (id)[SQTrainingMusclesPresenter new];
    id<SQViperInteractorPrivate> interactor = (id)[[SQTrainingMusclesInteractor alloc]initWithTrainingMusclesDataService:service];
    id<SQViperWireframePrivate> wireframe = (id)[SQTrainingMusclesWireframe new];
    [self assembleViperForView:view
                     presenter:presenter
                    interactor:interactor
                     wireframe:wireframe
                        router:router];
}

@end
