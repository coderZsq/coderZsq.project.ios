//
//  ViewController.m
//  SQIntervalTimer
//
//  Created by 朱双泉 on 2019/10/11.
//  Copyright © 2019 朱双泉. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UIButton *controlButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 60; i++) {
        [self.dataSource addObject:@(i).stringValue];
    }
    self.controlButton.layer.cornerRadius = self.controlButton.bounds.size.width * 0.5;
    self.controlButton.layer.masksToBounds = YES;
    self.cancelButton.layer.cornerRadius = self.cancelButton.bounds.size.width * 0.5;
    self.cancelButton.layer.masksToBounds = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[NSAttributedString alloc] initWithString:self.dataSource[row] attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

@end
