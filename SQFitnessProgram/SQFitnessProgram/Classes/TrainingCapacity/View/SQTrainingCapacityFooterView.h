//
//  SQTrainingCapacityFooterView.h
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2018/12/31.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQTrainingCapacityFooterView : UIView

@property (weak, nonatomic) IBOutlet UILabel *totalCapacityLabel;

+ (instancetype)footerView;

@end

NS_ASSUME_NONNULL_END
