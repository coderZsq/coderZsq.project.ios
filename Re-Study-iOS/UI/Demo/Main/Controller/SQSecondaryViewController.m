//
//  SQSecondaryViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSecondaryViewController.h"
#import "SQCityButton.h"
#import "SQCityCell.h"

@interface SQSecondaryViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton * preSelectedButton;
@property (weak, nonatomic) IBOutlet SQCityButton *cityButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (nonatomic, assign, getter=isOpen) BOOL open;
@property (nonatomic, copy) NSArray * cityArrayI;
@end

@implementation SQSecondaryViewController

- (NSArray *)cityArrayI {
    
    if (!_cityArrayI) {
        _cityArrayI = @[@"Shanghai", @"Beijing", @"Shenzhen", @"Guangzhou"];
    }
    return _cityArrayI;
}

- (IBAction)cityButtonClick:(SQCityButton *)sender {
    [UIView animateWithDuration:.25 animations:^{
        self.heightConstraint.constant = self.isOpen ? 0 : 44 * 4;
        [self.view layoutIfNeeded];
    }];
    self.open = !self.isOpen;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.x = self.cityButton.x;
    self.tableView.y = CGRectGetMaxY(self.cityButton.frame);
    self.tableView.width = self.cityButton.width;
    self.tableView.backgroundColor = self.cityButton.backgroundColor;
    self.tableView.layer.cornerRadius = self.cityButton.layer.cornerRadius;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 15);
    self.tableView.alpha = .9;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (IBAction)menuButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(secondaryViewController:currentButtonIndex:preButtonIndex:)]) {
        [self.delegate secondaryViewController:self currentButtonIndex:sender.tag preButtonIndex:self.preSelectedButton.tag];
    }
    self.preSelectedButton.selected = NO;
    sender.selected = YES;
    self.preSelectedButton = sender;
}

- (IBAction)exitButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.cityArrayI.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQCityCell * cell = [SQCityCell cellWithTableView:tableView];
    cell.textLabel.text = self.cityArrayI[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * city = self.cityArrayI[indexPath.row];
    [self.cityButton setTitle:city forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(secondaryViewControllerDidClickedCityButton:)]) {
        [self.delegate secondaryViewControllerDidClickedCityButton:self];
    }
    [self cityButtonClick:self.cityButton];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"cityChanged" object:city];
}

@end
