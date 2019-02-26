//
//  SQTrainingDateListWireframe.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingDateListWireframe.h"
#import "SQTrainingDateListRouter.h"
#import "SQViperViewPrivate.h"

@interface SQTrainingDateListWireframe ()

@property (nonatomic, weak) id<SQViperViewPrivate> view;
@property (nonatomic, strong) id<SQTrainingDateListRouter> router;

@end

@implementation SQTrainingDateListWireframe

- (void)pushTrainingCapacityWithTitle:(NSString *)title type:(SQTrainingCapacityMuscleType)type {
    UIViewController *trainingCapacityViewController = [[self.router class]viewForTrainingCapacityWithTitle:title type:type];
    [[self.router class] pushViewController:trainingCapacityViewController fromViewController:self.view.routeSource animated:YES];
}

@end
