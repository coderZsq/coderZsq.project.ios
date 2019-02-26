//
//  SQTrainingCapacityTextField.m
//  SQFitnessProgram
//
//  Created by 朱双泉 on 2019/1/2.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQTrainingCapacityTextField.h"

@interface SQTrainingCapacityTextField () <UITextFieldDelegate>

@end

@implementation SQTrainingCapacityTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.text = @"";
    return YES;
}

@end
