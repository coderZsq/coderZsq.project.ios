//
//  SQHomeViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQHomeViewController.h"
#import "SQSectionItem.h"
#import "SQHomeCellItem.h"
#import "SQHomeCell.h"
#import "SQSectionView.h"
#import "UIColor+SQExtension.h"

@interface SQHomeViewController ()
@property (nonatomic, copy) NSArray * dataSource;
@end

@implementation SQHomeViewController

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [SQSectionItem getSectionItem];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.tableView.rowHeight = 161;
    self.tableView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"bgImage"].CGImage);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SQHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SQHomeCell class])];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SQSectionItem * item = self.dataSource[section];
    return item.body.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQHomeCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SQHomeCell class])];
    SQSectionItem * item = self.dataSource[indexPath.section];
    SQHomeCellItem * cellItem = item.body[indexPath.row];
    cell.backgroundImageView.image = [UIImage imageNamed:cellItem.imageURL];
    cell.titleLabel.text = cellItem.section_title;
    cell.descriptionLabel.text = cellItem.poi_name;
    cell.supportLabel.text = cellItem.fav_count;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SQSectionItem * item = self.dataSource[section];
    SQSectionView * view = [SQSectionView sectionView];
    view.titleLabel.text = item.tag_name;
    view.descriptionLabel.text = item.section_count;
    view.backgroundColor = [UIColor colorWithHexString:item.color];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
