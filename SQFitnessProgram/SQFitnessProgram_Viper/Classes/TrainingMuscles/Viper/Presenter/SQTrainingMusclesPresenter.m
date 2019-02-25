//
//  SQTrainingMusclesPresenter.m
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/25.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingMusclesPresenter.h"
#import "SQTrainingMusclesWireframeInput.h"
#import "SQTrainingMusclesInteractorInput.h"
#import "SQViperInteractor.h"

@interface SQTrainingMusclesPresenter ()

@property (nonatomic, strong) id<SQTrainingMusclesWireframeInput> wireframe;
@property (nonatomic, weak) id<SQViperView> view;
@property (nonatomic, strong) id<SQViperInteractor, SQTrainingMusclesInteractorInput> interactor;

@end

@implementation SQTrainingMusclesPresenter

- (void)handleViewReady {
    NSAssert(self.wireframe, @"Router should be initlized when view is ready.");
    NSAssert([self.view conformsToProtocol:@protocol(SQViperView)], @"Presenter should be attach to a view");
    NSAssert([self.interactor conformsToProtocol:@protocol(SQViperInteractor)], @"Interactor should be initlized when view is ready.");
    [self.interactor loadDataSource];
}

- (void)handleViewWillAppear:(BOOL)animated {
}

- (void)handleViewDidAppear:(BOOL)animated {
}

- (void)handleViewWillDisappear:(BOOL)animated {
}

- (void)handleViewDidDisappear:(BOOL)animated {
}

- (void)handleViewRemoved {
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
