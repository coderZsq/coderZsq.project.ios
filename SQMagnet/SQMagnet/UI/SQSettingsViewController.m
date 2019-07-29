//
//  SQSettingsViewController.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQSettingsViewController.h"
#import "SQH1TitleView.h"
#import "UIViewController+SQExtension.h"
#import <SafariServices/SafariServices.h>
#import "SQConnectViewController.h"
#import "SQLongViewController.h"
#import "SQDisclaimerViewController.h"

@interface SQSettingsViewController ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIColor *defaultColor;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation SQSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    self.titleLabel = [self findNavigationBarContentViewTitleLabel];
    self.defaultColor = self.titleLabel.textColor;
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = self.titleLabel.font;
    titleLabel.text = self.titleLabel.text;
    titleLabel.textColor = [UIColor clearColor];
    titleLabel.frame = self.titleLabel.frame;
    self.navigationItem.titleView = titleLabel;
    self.titleLabel = titleLabel;
    
    self.tableView.rowHeight = 60;
    self.datas = @[@[@"如何使用", @"免责声明", @"用户反馈"], @[@"关于作者",  @"勾搭作者"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *datas = self.datas[section];
    return datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *datas = self.datas[indexPath.section];
    cell.textLabel.text = datas[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        SQLongViewController *longVC = [SQLongViewController new];
        longVC.title = @"如何使用";
        longVC.imageNamed = @"howtouse";
        [self.navigationController pushViewController:longVC animated:YES];
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        SQDisclaimerViewController *disclaimerVC = [[UIStoryboard storyboardWithName:NSStringFromClass(SQDisclaimerViewController.class) bundle:nil] instantiateInitialViewController];
        disclaimerVC.title = @"免责声明";
        [self.navigationController pushViewController:disclaimerVC animated:YES];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        SQConnectViewController *connectVC = [[UIStoryboard storyboardWithName:NSStringFromClass(SQConnectViewController.class) bundle:nil] instantiateInitialViewController];
        connectVC.imageNamed = @"feedback";
        connectVC.title = @"用户反馈";
        [self.navigationController pushViewController:connectVC animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        NSURL *url = [NSURL URLWithString: @"https://github.com/coderZsq"];
        SFSafariViewController *safarivc = [[SFSafariViewController alloc] initWithURL:url];
        [self presentViewController:safarivc animated:YES completion:nil];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        SQConnectViewController *connectVC = [[UIStoryboard storyboardWithName:NSStringFromClass(SQConnectViewController.class) bundle:nil] instantiateInitialViewController];
        connectVC.imageNamed = @"me";
        connectVC.title = @"勾搭作者";
        [self.navigationController pushViewController:connectVC animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) return [SQH1TitleView viewWithTitle:self.title];
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 64;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.titleLabel.textColor = scrollView.contentOffset.y > -48.f ? self.defaultColor : [UIColor clearColor];
}

@end
