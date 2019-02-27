//
//  SQTrainingDateListProtocol.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperView.h"
#import "SQTrainingCapacityMuscleType.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingDateListViewProtocol <SQViperView>

@property (nonatomic, readonly, assign) SQTrainingCapacityMuscleType type;

@property (nonatomic, readonly, weak) UITableView *tableView;

- (void)fetchDataSource;

@end

NS_ASSUME_NONNULL_END
