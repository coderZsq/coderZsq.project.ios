//
//  SQViperPresenterPrivate.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQViperView;
@protocol SQViperInteractor;
@protocol SQViperWireframe;

@protocol SQViperPresenterPrivate <SQViperPresenter>

- (id<SQViperWireframe>)wireframe;

- (void)setWireframe:(id<SQViperWireframe>)wireframe;

- (void)setView:(id<SQViperView>)view;

- (id<SQViperInteractor>)interactor;

- (void)setInteractor:(id<SQViperInteractor>)interactor;

@end

NS_ASSUME_NONNULL_END
