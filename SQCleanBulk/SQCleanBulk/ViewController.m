//
//  ViewController.m
//  SQCleanBulk
//
//  Created by 朱双泉 on 2019/10/10.
//  Copyright © 2019 朱双泉. All rights reserved.
//

#import "ViewController.h"
#import "SQNumberPadHandleView.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;
@property (weak, nonatomic) SQNumberPadHandleView *handleView;
@property (assign, nonatomic) NSInteger textFieldIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SQNumberPadHandleView *handleView = [SQNumberPadHandleView handleView];
    handleView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44);
    [handleView.completeButton addTarget:self action:@selector(completeButtonEvents:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:handleView];
    self.handleView = handleView;
    self.textFieldIndex = 0;
    for (UITextField *textField in self.textFields) {
        CALayer *underline = [CALayer new];
        underline.frame = CGRectMake(10, textField.frame.size.height - 4, textField.frame.size.width - 20, 2.0);
        underline.backgroundColor = [UIColor whiteColor].CGColor;
        [textField.layer addSublayer:underline];
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
        textField.delegate = self;
        if (self.textFieldIndex == 0) {
            [textField becomeFirstResponder];
            self.textFieldIndex = -1;
        }
    }
    self.startButton.layer.cornerRadius = self.startButton.bounds.size.width * 0.5;
    self.startButton.layer.masksToBounds = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.textFieldIndex = [self.textFields indexOfObject:textField];
    NSLog(@"%li", self.textFieldIndex);
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField.text.length > 2) {
        textField.text = [textField.text substringToIndex:2];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.handleView.frame;
        frame.origin.y = self.view.bounds.size.height - keyboardFrame.size.height - self.handleView.frame.size.height;
        self.handleView.frame = frame;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.handleView.frame;
        frame.origin.y = self.view.bounds.size.height + 20;
        self.handleView.frame = frame;
    }];
}

- (void)completeButtonEvents:(UIButton *)sender {
    NSLog(@"%li - %li", self.textFieldIndex + 1, self.textFields.count);
    if (self.textFieldIndex + 1 == self.textFields.count) {
        UITextField *textField = self.textFields.lastObject;
        [textField resignFirstResponder];
        return;
    }
    while (true) {
        UITextField *textField = self.textFields[++self.textFieldIndex];
        if (!textField.text.length) {
            [textField becomeFirstResponder];
            break;
        }
    }
}

@end
