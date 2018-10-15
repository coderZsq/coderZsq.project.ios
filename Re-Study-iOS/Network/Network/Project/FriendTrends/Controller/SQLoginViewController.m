//
//  SQLoginViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/15.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQLoginViewController.h"
#import "SQLoginRegisterView.h"

@interface SQLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;
@end

@implementation SQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SQLoginRegisterView * loginView  = [SQLoginRegisterView loginView];
    loginView.width = self.view.width;
    [_middleView addSubview:loginView];
    SQLoginRegisterView * registerView = [SQLoginRegisterView registerView];
    registerView.x = registerView.width = self.view.width;
    [_middleView addSubview:registerView];
}

- (IBAction)closeButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.leadingConstraint.constant = _leadingConstraint.constant == 0 ? -self.view.width : 0;
    [UIView animateWithDuration:.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
