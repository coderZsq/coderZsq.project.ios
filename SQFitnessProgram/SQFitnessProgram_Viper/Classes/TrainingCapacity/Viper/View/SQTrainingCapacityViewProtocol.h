//
//  SQTrainingCapacityViewProtocol.h
//  SQFitnessProgram_Viper
//
//  Created by 朱双泉 on 2019/2/27.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQViperView.h"
#import "SQTrainingCapacityMuscleType.h"
#import "SQTrainingCapacityFooterView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQTrainingCapacityViewProtocol <SQViperView>

@property (nonatomic, readonly, copy) NSString *title;

@property (nonatomic, readonly, assign) SQTrainingCapacityMuscleType type;

@property (nonatomic, readonly, weak) UITableView *tableView;

@property (nonatomic, readonly, weak) SQTrainingCapacityFooterView *footerView;

- (void)fetchDataSource;

- (void)setRightBarButtonItem:(UIBarButtonSystemItem)item target:(nullable id)target action:(nullable SEL)action;

@end

NS_ASSUME_NONNULL_END
