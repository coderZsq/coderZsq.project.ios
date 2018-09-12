//
//  NavigationViewController3.m
//  UI
//
//  Created by 朱双泉 on 2018/9/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "NavigationViewController3.h"
#import "ContactModel.h"
#import "UIViewController+Navigation.h"

@interface NavigationViewController3 ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *telTextField;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@end

@implementation NavigationViewController3

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self defaultNavigationLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defaultNavigationSetting];

    [self.nameTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.telTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self textChange:nil];
    
    if (self.model) {
        self.title = @"Edit contact";
        self.nameTextField.enabled = NO;
        self.telTextField.enabled = NO;
        self.nameTextField.text = self.model.name;
        self.telTextField.text = self.model.tel;
        self.button.hidden = YES;
        [self.button setTitle:@"Save" forState:UIControlStateNormal];
    } else {
        self.title = @"Add contact";
        self.editButton.hidden = YES;
        [self.button setTitle:@"Add" forState:UIControlStateNormal];
    }
}

- (void)textChange:(UITextField *)sender {
    self.button.enabled = self.nameTextField.text.length && self.telTextField.text.length;
}

- (IBAction)buttonClick:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"Add"]) {
        ContactModel * model = [ContactModel contactModelWithName:self.nameTextField.text tel:self.telTextField.text image:self.imageView.image];
        if ([self.delegate respondsToSelector:@selector(navigationViewController3:addModel:)]) {
            [self.delegate navigationViewController3:self addModel:model];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else if ([sender.titleLabel.text isEqualToString:@"Save"]) {
        self.model.name = self.nameTextField.text;
        self.model.tel = self.telTextField.text;
        if ([self.delegate respondsToSelector:@selector(navigationViewController3:saveModel:)]) {
            [self.delegate navigationViewController3:self saveModel:self.model];
        }        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)editButtonClick:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"Edit"]) {
        [sender setTitle:@"Cancel" forState: UIControlStateNormal];
        self.nameTextField.enabled = YES;
        self.telTextField.enabled = YES;
        self.button.hidden = NO;
        self.button.enabled = YES;
        [self.nameTextField becomeFirstResponder];
    } else {
        [sender setTitle:@"Edit" forState: UIControlStateNormal];
        self.nameTextField.enabled = NO;
        self.telTextField.enabled = NO;
        self.button.hidden = YES;
        self.nameTextField.text = self.model.name;
        self.telTextField.text = self.model.tel;
    }
}

@end
