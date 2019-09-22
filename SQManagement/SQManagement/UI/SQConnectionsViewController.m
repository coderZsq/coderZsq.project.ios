//
//  SQConnectionsViewController.m
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQConnectionsViewController.h"
#import "UIViewController+SQExtension.h"
#import "SQH1TitleView.h"
#import <Contacts/Contacts.h>

@interface SQConnectionsViewController ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIColor *defaultColor;

@end

@implementation SQConnectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"人脉";
    self.titleLabel = [self findNavigationBarContentViewTitleLabel];
    self.defaultColor = self.titleLabel.textColor;
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = self.titleLabel.font;
    titleLabel.text = self.titleLabel.text;
    titleLabel.textColor = [UIColor clearColor];
    titleLabel.frame = self.titleLabel.frame;
    self.navigationItem.titleView = titleLabel;
    self.titleLabel = titleLabel;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) return [SQH1TitleView viewWithTitle:self.title];
    else return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    self.titleLabel.textColor = scrollView.contentOffset.y > -48.f ? self.defaultColor : [UIColor clearColor];
}

@end
