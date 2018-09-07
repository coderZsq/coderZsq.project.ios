//
//  TableViewController3.m
//  UI
//
//  Created by 朱双泉 on 2018/9/7.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "TableViewController3.h"

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@end

@implementation TableViewCell
@end

@interface TableViewController3 ()
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, weak) UIBarButtonItem * addItem;
@property (nonatomic, weak) UIBarButtonItem * subItem;
@end

@implementation TableViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Cell Reload";
    
    UIBarButtonItem * addItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    UIBarButtonItem * subItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(sub:)];
    UIBarButtonItem * editItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItems = @[editItem, subItem, addItem];
    _addItem = addItem;
    _subItem = subItem;
    
//    self.tableView.allowsMultipleSelection = YES;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
#if 0
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
#endif
}

- (void)add:(UIBarButtonItem *)sender {
    NSDictionary * data = @{@"title" : @"Castie! Resume", @"description" : @"Shuangquan Zhu is a professional developer who focuses on iOS now. He has strong knowledge of Objective-C, C++ and Swift. With these skills, he created quite a few quickly developer tools. He also leads the J1 iOS team to promote the project process.\nHe crazy loves playing basketball with friends in spare time, He also loves traveling, writing and listening music. He is always willing to try new things, and keeping to learn from them."};
    [self.dataSource insertObject:data atIndex:0];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
}

- (void)sub:(UIBarButtonItem *)sender {
    if (self.tableView.isEditing) {
        NSMutableIndexSet * indexSet = [NSMutableIndexSet indexSet];
        for (NSIndexPath * indexPath in self.tableView.indexPathsForSelectedRows) {
            [indexSet addIndex:indexPath.row];
        }
        [self.dataSource removeObjectsAtIndexes:indexSet];
        [self.tableView deleteRowsAtIndexPaths:self.tableView.indexPathsForSelectedRows withRowAnimation:UITableViewRowAnimationRight];
    } else if (self.dataSource.count) {
        [self.dataSource removeObjectAtIndex:0];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    }
}

- (void)edit:(UIBarButtonItem *)sender {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    _addItem.enabled = !self.tableView.isEditing;
}
#if 0
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataSource removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
#endif
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction * action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (self.dataSource.count) {
            [self.dataSource removeObjectAtIndex:0];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        }
    }];
    UITableViewRowAction * action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"上天!!" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
    }];
    action2.backgroundColor = [UIColor darkGrayColor];
    UITableViewRowAction * action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"老子要" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
#if 0
        self.tableView.editing = NO;
#endif
    }];
    return @[action, action2, action3];
}

# if 0
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Delete";
}
#endif
- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"list" ofType:@"plist"]]];
    }
    return _dataSource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    cell.label.text = self.dataSource[indexPath.row][@"title"];
    cell.descLabel.text = self.dataSource[indexPath.row][@"description"];
    return cell;
}

# if 0
TableViewCell * cell;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
    if (!cell)
        cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    cell.label.text = self.dataSource[indexPath.row][@"title"];
    cell.descLabel.text = self.dataSource[indexPath.row][@"description"];
    cell.descLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
    [cell layoutIfNeeded];
    return CGRectGetMaxY(cell.descLabel.frame) + 10;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {}
#endif
@end
