//
//  SQViperWireframePrivate.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperWireframe.h"
#import "SQViperRouter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQViperWireframePrivate <SQViperWireframe>

- (void)setView:(id<SQViperView>)view;

- (id<SQViperRouter>)router;

- (void)setRouter:(id<SQViperRouter>)router;

@end

NS_ASSUME_NONNULL_END
