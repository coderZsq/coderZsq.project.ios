//
//  SQTrainingMusclesPresenter.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingMusclesPresenter.h"
#import "SQTrainingMusclesInteractorInput.h"
#import "SQTrainingMusclesWireframeInput.h"
#import "SQViperView.h"

@interface SQTrainingMusclesPresenter ()

@property (nonatomic, weak) id<SQViperView> view;
@property (nonatomic, strong) id<SQTrainingMusclesInteractorInput> interactor;
@property (nonatomic, strong) id<SQTrainingMusclesWireframeInput> wireframe;

@end

@implementation SQTrainingMusclesPresenter

- (void)handleViewReady {
    [self.interactor loadDataSource];
}

- (void)handleViewWillAppear:(BOOL)animated {
    NSLog(@"%s", __func__);
}

- (void)handleViewDidAppear:(BOOL)animated {
    NSLog(@"%s", __func__);
}

- (void)handleViewWillDisappear:(BOOL)animated {
    NSLog(@"%s", __func__);
}

- (void)handleViewDidDisappear:(BOOL)animated {
    NSLog(@"%s", __func__);
}

- (void)handleViewRemoved {
    NSLog(@"%s", __func__);
}

- (void)handleDidSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SQTrainingCapacityMuscleType type = [[self muscleTypeDictionary][[self.interactor fetchDataSource][indexPath.row]] integerValue];
    [self.wireframe pushTrainingDateListWithType:type];
}

- (NSDictionary *)muscleTypeDictionary {
    return @{
             @"Pectoral muscle" : @(SQTrainingCapacityMuscleTypePectoral),
             @"Back muscle" : @(SQTrainingCapacityMuscleTypeBack),
             @"Leg muscle" : @(SQTrainingCapacityMuscleTypeLeg),
             @"Shoulder muscle" : @(SQTrainingCapacityMuscleTypeShoulder),
             @"Arm muscle" : @(SQTrainingCapacityMuscleTypeArm),
             @"Abdominal muscle" : @(SQTrainingCapacityMuscleTypeAbdominal)
             };
}

- (NSArray *)fetchDataSource {
    return [self.interactor fetchDataSource];
}

@end
