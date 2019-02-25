//
//  SQTrainingDateListBuilder.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingDateListBuilder.h"
#import "SQTrainingDateListViewController.h"

@implementation SQTrainingDateListBuilder

+ (UIViewController *)viewControllerForTrainingDateListWithType:(SQTrainingCapacityMuscleType)type {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:self.class]];
    SQTrainingDateListViewController *view = [sb instantiateViewControllerWithIdentifier:@"SQTrainingDateListViewController"];
    view.type = type;
    return view;
}

@end
