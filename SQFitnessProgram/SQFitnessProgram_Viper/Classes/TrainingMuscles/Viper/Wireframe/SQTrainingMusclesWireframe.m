//
//  SQTrainingMusclesWireframe.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingMusclesWireframe.h"
#import "SQTrainingMusclesRouter.h"
#import "SQViperViewPrivate.h"

@interface SQTrainingMusclesWireframe ()

@property (nonatomic, weak) id<SQViperViewPrivate> view;
@property (nonatomic, strong) id<SQTrainingMusclesRouter> router;

@end

@implementation SQTrainingMusclesWireframe

- (void)pushTrainingDateListWithType:(SQTrainingCapacityMuscleType)type {
    UIViewController *trainingDateListViewController = [[self.router class] viewForTrainingDateListWithType:type];
    [[self.router class] pushViewController:trainingDateListViewController fromViewController:self.view.routeSource animated:YES];
}

@end
