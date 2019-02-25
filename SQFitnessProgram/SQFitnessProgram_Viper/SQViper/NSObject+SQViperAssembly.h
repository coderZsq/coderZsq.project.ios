//
//  NSObject+SQViperAssembly.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SQViperViewPrivate, SQViperPresenterPrivate, SQViperInteractorPrivate, SQViperWireframePrivate, SQViperRouter;

@interface NSObject (SQViperAssembly)

+ (void)assembleViperForView:(id<SQViperViewPrivate>)view
                   presenter:(id<SQViperPresenterPrivate>)presenter
                  interactor:(id<SQViperInteractorPrivate>)interactor
                   wireframe:(id<SQViperWireframePrivate>)wireframe
                      router:(id<SQViperRouter>)router;

@end

NS_ASSUME_NONNULL_END
