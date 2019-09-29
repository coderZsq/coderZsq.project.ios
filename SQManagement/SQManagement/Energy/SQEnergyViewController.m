//
//  SQEnergyViewController.m
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQEnergyViewController.h"
#import "SQH1TitleView.h"
#import "SQSearchInputView.h"

@interface SQEnergyViewController ()

@end

@implementation SQEnergyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"精力";
}

- (BOOL)isShowNavigationShadowImage {
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 0;
    else return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%li", indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) return [SQH1TitleView viewWithTitle:self.title];
    else return [SQSearchInputView inputView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 64;
    return 44;
}

@end
