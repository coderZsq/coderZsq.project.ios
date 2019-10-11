//
//  ViewController.m
//  SQIntervalTimer
//
//  Created by 朱双泉 on 2019/10/11.
//  Copyright © 2019 朱双泉. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *circles;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *operators;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self configureView];
}

- (void)loadData {
    self.dataSource = [NSMutableArray array];
    NSMutableArray *actions = [NSMutableArray array];
    for (NSUInteger i = 0; i <= 60; i++)
        [actions addObject:@(i).stringValue];
    [self.dataSource addObject:actions];
    NSMutableArray *breaks = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 60; i++)
        [breaks addObject:@(i).stringValue];
    [self.dataSource addObject:breaks];
    NSMutableArray *times = [NSMutableArray array];
    for (NSUInteger i = 1; i < 100; i++)
        [times addObject:@(i).stringValue];
    [self.dataSource addObject:times];
    for (UIView *view in self.circles) {
        view.layer.cornerRadius = view.bounds.size.width * 0.5;
        view.layer.masksToBounds = YES;
    }
}

- (void)configureView {
        [self.segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:(UIControlEventValueChanged)];
    self.segmentedControl.selectedSegmentIndex = 1;
    [self segmentedControlValueChanged:self.segmentedControl];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataSource.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *rows = self.dataSource[component];
    return rows.count;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[NSAttributedString alloc] initWithString:self.dataSource[component][row] attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (void)segmentedControlValueChanged:(UISegmentedControl *)sender {
    for (UILabel *label in self.labels) {
        label.text = @[@"时", @"分", @"秒"][sender.selectedSegmentIndex];
    }
}

- (IBAction)operatorEventTouchUpInside:(UIButton *)sender {
    for (UIView *operator in self.operators) {
        operator.backgroundColor = [UIColor colorWithRed:133 / 255. green:85 / 255. blue:32 / 255. alpha:1];
        if ([operator isKindOfClass:UIButton.class]) {
            UIButton *button = (UIButton *)operator;
            [button setTitle:@"暂停" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:255 / 255. green:182 / 255. blue:62 / 255. alpha:1] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)cancelEventTouchUpInside:(UIButton *)sender {
}

@end
