//
//  TableViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/7.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "TableViewController.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>
#import "TableViewController2.h"

@interface __Data: NSObject
@property (nonatomic, copy) NSString * text;
@property (nonatomic, copy) NSString * imageName;
+ (instancetype)dataWithText:(NSString *)text imageName:(NSString *)imageName;
+ (instancetype)dataWithDict:(NSDictionary *)dict;
@end

@implementation __Data

+ (instancetype)dataWithText:(NSString *)text imageName:(NSString *)imageName {
    __Data * data = [__Data new];
    data.text = text;
    data.imageName = imageName;
    return data;
}

+ (instancetype)dataWithDict:(NSDictionary *)dict {
    __Data * data = [self new];
    data.text = dict[@"text"];
    data.imageName = dict[@"imageName"];
    return data;
}

@end

@interface __Group: NSObject
@property (nonatomic, copy) NSString * titleHeader;
@property (nonatomic, copy) NSString * titleFooter;
@property (nonatomic, copy) NSArray * groups;
+ (instancetype)groupWithDict:(NSDictionary *)dict;
@end

@implementation __Group

+ (instancetype)groupWithDict:(NSDictionary *)dict {
    __Group * group = [self new];
    group.titleHeader = dict[@"titleHeader"];
    group.titleFooter = dict[@"titleFooter"];
    NSMutableArray * groups = [NSMutableArray array];
    for (NSDictionary * __dict in dict[@"groups"]) {
        __Data * data = [__Data dataWithDict:__dict];
        [groups addObject:data];
    }
    group.groups = groups;
    return group;
}

@end

@interface TableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, copy) NSArray * dataSource;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Table View";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
//    tableView.rowHeight = 44;
//    tableView.sectionHeaderHeight = 44;
//    tableView.sectionFooterHeight = 44;
//    tableView.separatorColor = [UIColor lightGrayColor];
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.tableHeaderView = [UISwitch new];
//    tableView.tableFooterView = [UISwitch new];
}

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        NSArray * data = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"groups" ofType:@"plist"]];
        NSMutableArray * dataSource = [NSMutableArray array];
        for (NSDictionary * dict in data) {
            __Group * group = [__Group groupWithDict:dict];
            [dataSource addObject:group];
        }
        _dataSource = dataSource;
    }
    return _dataSource;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    __Group * group = self.dataSource[section];
    return group.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __Group * group = self.dataSource[indexPath.section];
    __Data * data = group.groups[indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
#if 0
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
#endif
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = data.text;
    cell.imageView.image = [UIImage imageNamed:data.imageName];
    
//    cell.accessoryView = [UISwitch new];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    UIView * view = [UIView new];
//    view.backgroundColor = [UIColor lightGrayColor];
//    cell.selectedBackgroundView = view;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    __Group * group = self.dataSource[section];
    return group.titleHeader;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    __Group * group = self.dataSource[section];
    return group.titleFooter;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[TableViewController2 new] animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
}
#if 0
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {}
#endif

@end
