//
//  NSObject+SQViperAssembly.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "NSObject+SQViperAssembly.h"

@implementation NSObject (SQViperAssembly)

+ (void)assembleViperForView:(id<SQViperViewPrivate>)view presenter:(id<SQViperPresenterPrivate>)presenter interactor:(id<SQViperInteractorPrivate>)interactor wireframe:(id<SQViperWireframePrivate>)wireframe router:(id<SQViperRouter>)router {
    
    NSParameterAssert([view conformsToProtocol:@protocol(SQViperView)]);
    NSParameterAssert([presenter conformsToProtocol:@protocol(SQViperPresenter)]);
    NSParameterAssert([interactor conformsToProtocol:@protocol(SQViperInteractor)]);
    NSParameterAssert([wireframe conformsToProtocol:@protocol(SQViperWireframe)]);
    NSParameterAssert([router conformsToProtocol:@protocol(SQViperRouter)]);
    
    NSAssert3(interactor.eventHandler == nil, @"Interactor (%@)'s eventHandler (%@) already exists when assemble viper for new eventHandler", interactor, interactor.eventHandler, presenter);
    NSAssert3(interactor.dataSource == nil, @"Interactor (%@)'s dataSource (%@) already exists when assemble viper for new dataSource", interactor, interactor.dataSource, presenter);
    
    interactor.eventHandler = presenter;
    interactor.dataSource = presenter;
    
    NSAssert3(wireframe.view == nil, @"Wireframe (%@)'s view (%@) already exists when assemble viper for new view", wireframe, wireframe.view, view);
    
    wireframe.view = view;
    wireframe.router = router;
    
    NSAssert3(presenter.interactor == nil, @"Presenter (%@)'s interactor already exists when assemble viper for new interactor", presenter, presenter.interactor, interactor);
    NSAssert3(presenter.view == nil, @"Presenter (%@)'s view already exists when assemble viper for new view", presenter, presenter.view, view);
    NSAssert3(presenter.wireframe == nil, @"Presenter (%@)'s wireframe (%@) already exists assemble viper for new router", presenter, presenter.wireframe, self);
    
    presenter.interactor = interactor;
    presenter.view = view;
    presenter.wireframe = wireframe;
    
    if ([view respondsToSelector:@selector(viewDataSource)] &&
        [view respondsToSelector:@selector(setViewDataSource:)]) {
        NSAssert3(view.viewDataSource == nil, @"View (%@)'s viewDataSource (%@) already exists when assemble viper for new viewDataSource", view, view.viewDataSource, presenter);
        view.viewDataSource = presenter;
    }
    
    NSAssert3(view.eventHandler == nil, @"View (%@)'s eventHandler (%@) already exists when assemble viper for new eventHandler", view, view.eventHandler, presenter);
    
    view.eventHandler = presenter;
}

@end
