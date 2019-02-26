//
//  SQTrainingCapacityCell.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2018/12/31.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQTrainingCapacityCell.h"

@implementation SQTrainingCapacityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupTextFieldBorder:self.contentView];
}

- (void)setupTextFieldBorder:(UIView *)contentView {
    [contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            obj.layer.borderColor = [UIColor lightGrayColor].CGColor;
            obj.layer.borderWidth = 0.3;
        } else if (obj.subviews.count) {
            [self setupTextFieldBorder:obj];
        }
    }];
}

@end
