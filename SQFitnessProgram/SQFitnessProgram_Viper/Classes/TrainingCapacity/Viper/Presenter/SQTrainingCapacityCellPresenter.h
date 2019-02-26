//
//  SQTrainingCapacityCellPresenter.h
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2019/1/2.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SQTrainingCapacityModel;
@class SQTrainingCapacityCell;

@interface SQTrainingCapacityCellPresenter : NSObject

@property (nonatomic, strong) SQTrainingCapacityModel * model;

- (void)bindToCell:(SQTrainingCapacityCell *)cell;

@end

NS_ASSUME_NONNULL_END
