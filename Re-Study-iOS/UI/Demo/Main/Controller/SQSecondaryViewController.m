//
//  SQSecondaryViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSecondaryViewController.h"

@interface SQSecondaryViewController ()
@property (weak, nonatomic) IBOutlet UIButton * preSelectedButton;
@end

@implementation SQSecondaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)menuButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(secondaryViewController:currentButtonIndex:preButtonIndex:)]) {
        [self.delegate secondaryViewController:self currentButtonIndex:sender.tag preButtonIndex:self.preSelectedButton.tag];
    }
    self.preSelectedButton.selected = NO;
    sender.selected = YES;
    self.preSelectedButton = sender;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
