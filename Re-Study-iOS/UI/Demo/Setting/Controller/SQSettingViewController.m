//
//  SQSettingViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSettingViewController.h"
#import "SQSettingRowItem.h"
#import "SQSettingGroupItem.h"

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
    
    for (NSInteger i = 0; i < arc4random_uniform(5) + 1; i++) {
        NSMutableArray * rowItems = @[].mutableCopy;
        for (NSInteger j = 0; j < arc4random_uniform(5) + 1; j++) {
            SQSettingRowItem * rowItem = [SQSettingRowItem itemWithImage:[UIImage imageNamed:@"Avatar"] title:[NSString stringWithFormat:@"Castie! - %li - %li", i, j]];
            rowItem.rowType = (i + j) % 2 ? SQRowTypeArrow : SQRowTypeSwitch;
            if (rowItem.rowType == SQRowTypeArrow) {
                rowItem.destinationClass = [SQSettingViewController class];
            }
            [rowItems addObject:rowItem];
        }
        SQSettingGroupItem * groupItem = [SQSettingGroupItem itemWithRowItems:rowItems];
        groupItem.headerTitle = [NSString stringWithFormat:@"group - %li", i];
        groupItem.footerTitle = [NSString stringWithFormat:@"group - %li", i];
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"identifier"];
    }
    cell.imageView.image = rowItem.image;
    cell.textLabel.text = rowItem.title;
    if (rowItem.rowType == SQRowTypeArrow) {
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
    } else if (rowItem.rowType == SQRowTypeSwitch) {
        cell.accessoryView = [UISwitch new];
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
    if (rowItem.destinationClass) {
        [self.navigationController pushViewController:[rowItem.destinationClass new] animated:YES];
    }
}

@end
