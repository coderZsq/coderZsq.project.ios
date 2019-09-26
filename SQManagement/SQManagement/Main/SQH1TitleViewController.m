//
//  SQH1TitleViewController.m
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/26.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQH1TitleViewController.h"
#import "SQH1TitleView.h"
#import "UIViewController+SQExtension.h"

@interface SQH1TitleViewController ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIColor *defaultColor;
@property (nonatomic, assign, getter=isFirstAppear) BOOL firstAppear;
@end

@implementation SQH1TitleViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.isFirstAppear) {
        self.titleLabel = [self findNavigationBarContentViewTitleLabel];
        self.defaultColor = self.titleLabel.textColor;
        UILabel *titleLabel = [UILabel new];
        titleLabel.font = self.titleLabel.font;
        titleLabel.text = self.titleLabel.text;
        titleLabel.textColor = [UIColor clearColor];
        titleLabel.frame = self.titleLabel.frame;
        self.navigationItem.titleView = titleLabel;
        self.titleLabel = titleLabel;
        self.firstAppear = YES;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) return [SQH1TitleView viewWithTitle:self.title];
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 64;
    return 44;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    self.titleLabel.textColor = scrollView.contentOffset.y > -48.f ? self.defaultColor : [UIColor clearColor];
}

@end
