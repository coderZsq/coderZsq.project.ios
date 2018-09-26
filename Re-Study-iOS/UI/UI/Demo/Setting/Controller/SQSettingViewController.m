//
//  SQSettingViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSettingViewController.h"
#import "SQSettingRowItem.h"
#import "SQSettingArrowItem.h"
#import "SQSettingSwitchItem.h"
#import "SQSettingGroupItem.h"
#import <MBProgressHUD.h>
#import "SQSettingCell.h"

@interface SQSettingViewController ()
@property (nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation SQSettingViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Setting";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 44)];
    UIButton * button = [UIButton new];
    button.backgroundColor = SystemColor;
    [button setTitle:@"FooterView" forState:UIControlStateNormal];
    button.x = 10;
    button.width = ScreenWidth - 2 * button.x;
    button.height = 44;
    button.layer.cornerRadius = 8;
    [footerView addSubview:button];
    self.tableView.tableFooterView = footerView;
    
    __weak typeof (self) _self = self;
    for (NSInteger i = 0; i < arc4random_uniform(5) + 1; i++) {
        NSMutableArray * rowItems = @[].mutableCopy;
        for (NSInteger j = 0; j < arc4random_uniform(5) + 3; j++) {
            SQSettingRowItem * rowItem;
            if (j == 0) {
                SQSettingArrowItem * arrowItem = [SQSettingArrowItem itemWithImage:[UIImage imageNamed:@"sound_Effect"] title:[NSString stringWithFormat:@"Castie! - %li - %li", i, j]];
                arrowItem.destinationClass = [SQSettingViewController class];
                __weak SQSettingArrowItem * _arrowItem = arrowItem;
                arrowItem.destinationTask = ^{
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:_self.view animated:YES];
                        [_self.navigationController pushViewController:[_arrowItem.destinationClass new] animated:YES];
                    });
                };
                rowItem = arrowItem;
            } else if (j == 1) {
                SQSettingSwitchItem * switchItem = [SQSettingSwitchItem itemWithImage:[UIImage imageNamed:@"MorePush"] title:[NSString stringWithFormat:@"Castie! - %li - %li", i, j]];
                rowItem = switchItem;
            } else {
                rowItem = [SQSettingRowItem itemWithImage:[UIImage imageNamed:@"MoreShare"] title:[NSString stringWithFormat:@"Castie! - %li - %li", i, j]];
                rowItem.subTitle = @"coderZsq";
            }
            [rowItems addObject:rowItem];
        }
        SQSettingGroupItem * groupItem = [SQSettingGroupItem itemWithRowItems:rowItems];
        groupItem.headerTitle = [NSString stringWithFormat:@"header group - %li", i];
        groupItem.footerTitle = [NSString stringWithFormat:@"footer group - %li Be a part of something bigger than yourself.", i];
        [self.dataSource addObject:groupItem];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SQSettingGroupItem * item = self.dataSource[section];
    return item.rowItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQSettingGroupItem * item = self.dataSource[indexPath.section];
    SQSettingRowItem * rowItem = item.rowItems[indexPath.row];
    SQSettingCell * cell = [SQSettingCell cellWithTableView:tableView style:indexPath.row % 2 ? UITableViewCellStyleValue1 : UITableViewCellStyleSubtitle];
    cell.imageView.image = rowItem.image;
    cell.textLabel.text = rowItem.title;
    cell.detailTextLabel.text = rowItem.subTitle;
    if ([rowItem isKindOfClass:[SQSettingArrowItem class]]) {
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
    } else if ([rowItem isKindOfClass:[SQSettingSwitchItem class]]) {
        cell.accessoryView = [UISwitch new];
    } else {
        cell.accessoryView = nil;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    SQSettingGroupItem * item = self.dataSource[section];
    return item.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    SQSettingGroupItem * item = self.dataSource[section];
    return item.footerTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SQSettingGroupItem * item = self.dataSource[indexPath.section];
    SQSettingRowItem * rowItem = item.rowItems[indexPath.row];
    if ([rowItem isKindOfClass:[SQSettingArrowItem class]]) {
        SQSettingArrowItem * arrowItem = (SQSettingArrowItem *)rowItem;
        if (arrowItem.destinationTask) {
            arrowItem.destinationTask();
            return;
        }
        if (arrowItem.destinationClass) {
            [self.navigationController pushViewController:[arrowItem.destinationClass new] animated:YES];
        }
    } else if ([rowItem isKindOfClass:[SQSettingRowItem class]]) {
        SQSettingCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = cell.textLabel.text;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }
}

@end
