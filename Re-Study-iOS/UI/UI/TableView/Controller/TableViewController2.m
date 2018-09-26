//
//  TableViewController2.m
//  UI
//
//  Created by 朱双泉 on 2018/9/7.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "TableViewController2.h"
#import <MJExtension.h>

@interface __Data2: NSObject
@property (nonatomic, copy) NSString * text;
@property (nonatomic, copy) NSString * imageName;
@end

@implementation __Data2
@end

@interface __Group2: NSObject
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSArray * groups;
@end

@implementation __Group2
#if 0
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"groups": [__Data2 class]};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"groups": @"__Data2"};
}
#endif
@end

@interface TableViewController2 ()
@property (nonatomic, copy) NSArray * dataSource;
@end

@implementation TableViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Plain Style";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    
//    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
//    self.tableView.sectionIndexBackgroundColor = [UIColor darkGrayColor];
}

- (NSArray *)dataSource {
    
    if (!_dataSource) {
#if 0
        [__Group2 mj_objectArrayWithKeyValuesArray:data];
        [__Group2 mj_objectArrayWithFile:[[NSBundle mainBundle]pathForResource:@"tableview2" ofType:@"plist"]];
#endif
        [__Group2 mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"groups": @"__Data2"};
        }];
        _dataSource = [__Group2 mj_objectArrayWithFilename:@"tableview2.plist"];
    }
    return _dataSource;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    __Group2 * group = self.dataSource[section];
    return group.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __Group2 * group = self.dataSource[indexPath.section];
    __Data2 * data = group.groups[indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    cell.textLabel.text = data.text;
    cell.imageView.image = [UIImage imageNamed:data.imageName];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    __Group2 * group = self.dataSource[section];
    return group.title;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.dataSource valueForKeyPath:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"TableViewController3" bundle:nil];
    [self.navigationController pushViewController:[sb instantiateInitialViewController] animated:YES];
}

@end
