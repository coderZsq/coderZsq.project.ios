//
//  SQTrainingCapacityBuilder.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingCapacityBuilder.h"
#import "SQTrainingCapacityViewController.h"
#import "SQTrainingCapacityPresenter.h"
#import "SQTrainingCapacityInteractor.h"
#import "SQTrainingCapacityWireframe.h"
#import "SQTrainingCapacityDataManager.h"
#import "NSObject+SQViperAssembly.h"

@implementation SQTrainingCapacityBuilder

+ (UIViewController *)viewControllerForTrainingCapacityWithTitle:(NSString *)title type:(SQTrainingCapacityMuscleType)type router:(id<SQViperRouter>)router {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:self.class]];
    SQTrainingCapacityViewController *view = [sb instantiateViewControllerWithIdentifier:@"SQTrainingCapacityViewController"];
    NSAssert([view isKindOfClass:[SQTrainingCapacityViewController class]], nil);
    view.title = title;
    view.type = type;
    [self buildView:(id<SQViperViewPrivate>)view trainingDateListDataService:[SQTrainingCapacityDataManager new] router:router];
    return view;
}

+ (void)buildView:(id<SQViperViewPrivate>)view trainingDateListDataService:(id<SQTrainingCapacityDataService>)service router:(id<SQViperRouter>)router {
    id<SQViperPresenterPrivate> presenter = (id)[SQTrainingCapacityPresenter new];
    id<SQViperInteractorPrivate> interactor = [(id)[SQTrainingCapacityInteractor alloc]initWithTrainingCapacityDataService:service];
    id<SQViperWireframePrivate> wireframe = (id)[SQTrainingCapacityWireframe new];
    [self assembleViperForView:view
                     presenter:presenter
                    interactor:interactor
                     wireframe:wireframe
                        router:router];
}

@end
