//
//  SQTrainingCapacityCell.h
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2018/12/31.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQTrainingCapacityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *actionsTextField;

@property (weak, nonatomic) IBOutlet UITextField *capacityTextField;

@property (strong, nonatomic) IBOutletCollection(UIStackView) NSArray *rows;

@end

NS_ASSUME_NONNULL_END
