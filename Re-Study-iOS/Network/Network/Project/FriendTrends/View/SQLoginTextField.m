//
//  SQLoginTextField.m
//  Network
//
//  Created by 朱双泉 on 2018/10/15.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQLoginTextField.h"
#import "UITextField+Placeholder.h"

@implementation SQLoginTextField

- (BOOL)becomeFirstResponder {
    [self editingDidBegin];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    [self editingDidEnd];
    return [super resignFirstResponder];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tintColor = [UIColor whiteColor];
//    [self addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
//    [self addTarget:self action:@selector(editingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
    [self editingDidEnd];
}

- (void)editingDidBegin {
    //    NSTextAttachment * attach = [[NSTextAttachment alloc]init];
    //    attach.image =
    //    attach.bounds
    //    NSAttributedString * attr = [NSAttributedString attributedStringWithAttachment:<#(nonnull NSTextAttachment *)#>]
//    NSAttributedString * attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//    self.attributedPlaceholder = attributedPlaceholder;
    self.placeholderColor = [UIColor whiteColor];
}

- (void)editingDidEnd {
//    NSAttributedString * attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
//    self.attributedPlaceholder = attributedPlaceholder;
    self.placeholderColor = [UIColor lightGrayColor];
}

@end
