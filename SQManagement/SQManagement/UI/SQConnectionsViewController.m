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
#import "SQSearchInputView.h"
#import "SQAuthorizationManager.h"

@interface SQConnectionsViewController ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIColor *defaultColor;
@property (nonatomic, strong) NSMutableArray *dataSource;
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
    
    self.dataSource = [NSMutableArray array];
    [SQAuthorizationManager fetchContacts:^(NSString *name, NSArray *phoneNumbers) {
        [self.dataSource addObject:name];
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 0;
    else return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    self.titleLabel.textColor = scrollView.contentOffset.y > -48.f ? self.defaultColor : [UIColor clearColor];
}

@end
