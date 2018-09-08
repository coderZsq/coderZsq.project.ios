//
//  TableViewController3.m
//  UI
//
//  Created by 朱双泉 on 2018/9/7.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "TableViewController3.h"
#import <MJExtension.h>

@interface __Model2: NSObject
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, assign, getter=isChecked) BOOL checked;
@end

@implementation __Model2
@end

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@end

@implementation TableViewCell
@end

@interface TableViewController3 ()
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, weak) UIBarButtonItem * insertItem;
@end

@implementation TableViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Cell Reload";
    
    UIBarButtonItem * insertItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insert:)];
    UIBarButtonItem * removeItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(remove:)];
    UIBarButtonItem * editItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItems = @[editItem, removeItem, insertItem];
    _insertItem = insertItem;
    
//    self.tableView.allowsMultipleSelection = YES;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
#if 0
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
#endif
}

- (void)insert:(UIBarButtonItem *)sender {
    __Model2 * model = [__Model2 new];
    model.title = [NSString stringWithFormat:@"Castie! Resume - %ld", self.dataSource.count];
    model.desc = @"Shuangquan Zhu is a professional developer who focuses on iOS now. He has strong knowledge of Objective-C, C++ and Swift. With these skills, he created quite a few quickly developer tools. He also leads the J1 iOS team to promote the project process.\nHe crazy loves playing basketball with friends in spare time, He also loves traveling, writing and listening music. He is always willing to try new things, and keeping to learn from them.";
    [self.dataSource insertObject:model atIndex:0];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
}

- (void)remove:(UIBarButtonItem *)sender {
    
    if (self.tableView.isEditing) {
        NSMutableIndexSet * indexSet = [NSMutableIndexSet indexSet];
        for (NSIndexPath * indexPath in self.tableView.indexPathsForSelectedRows) {
            [indexSet addIndex:indexPath.row];
        }
        [self.dataSource removeObjectsAtIndexes:indexSet];
        [self.tableView deleteRowsAtIndexPaths:self.tableView.indexPathsForSelectedRows withRowAnimation:UITableViewRowAnimationRight];
        return;
    }
    
    NSMutableIndexSet * indexSet = [NSMutableIndexSet indexSet];
    NSMutableArray * indexArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.dataSource.count; i++) {
        __Model2 * model = self.dataSource[i];
        if (model.isChecked) {
            [indexSet addIndex:i];
            [indexArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
    }
    if (indexSet.count) {
        [self.dataSource removeObjectsAtIndexes:indexSet];
        [self.tableView deleteRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationRight];
    } else if (self.dataSource.count) {
        [self.dataSource removeObjectAtIndex:0];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    }
}

- (void)edit:(UIBarButtonItem *)sender {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    _insertItem.enabled = !self.tableView.isEditing;
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
            [self.dataSource removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        }
    }];
    UITableViewRowAction * action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"My Best" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"TableViewController4" bundle:nil];
        [self.navigationController pushViewController:[sb instantiateViewControllerWithIdentifier:@"TableViewController4"] animated:YES];
    }];
    action2.backgroundColor = [UIColor darkGrayColor];
    UITableViewRowAction * action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Try" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
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
- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [__Model2 mj_objectArrayWithFilename:@"list.plist"];
    }
    return _dataSource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __Model2 * model = self.dataSource[indexPath.row];
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    cell.label.text = model.title;
    cell.descLabel.text = model.desc;
    cell.infoButton.enabled = model.isChecked;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!tableView.isEditing) {
        __Model2 * model = self.dataSource[indexPath.row];
        model.checked = !model.isChecked;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

# if 0
TableViewCell * cell;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
    __Model2 * model = self.dataSource[indexPath.row];
    if (!cell)
        cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    cell.label.text = model.title;
    cell.descLabel.text = model.desc;
    cell.descLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
    [cell layoutIfNeeded];
    return CGRectGetMaxY(cell.descLabel.frame) + 10;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {}
#endif
@end
