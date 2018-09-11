//
//  NavigationViewController2.m
//  UI
//
//  Created by 朱双泉 on 2018/9/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "NavigationViewController2.h"
#import "NavigationViewController3.h"
#import "ContactModel.h"

@interface NavigationViewController2 () </*UIActionSheetDelegate, UIAlertViewDelegate*/NavigationViewController3Delegate>
@property (nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation NavigationViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@'s Address book", self.accountName];
    self.tableView.tableFooterView = [UIView new];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NavigationViewController3 * vc = segue.destinationViewController;
    vc.delegate = self;
    if ([self.tableView indexPathForSelectedRow])
        vc.model = self.dataSource[[self.tableView indexPathForSelectedRow].row];
//    [segue perform];
//    [segue.sourceViewController.navigationController pushViewController:segue.destinationViewController animated:YES];
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        NSString * path =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString * filePath = [path stringByAppendingPathComponent:@"dataSource.data"];
        NSArray * dataSource = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        _dataSource = dataSource.count ? dataSource.mutableCopy : @[].mutableCopy;
    }
    return _dataSource;
}

- (void)navigationViewController3:(NavigationViewController3 *)vc addModel:(ContactModel *)model {
    [self.dataSource addObject:model];
    NSString * path =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString * filePath = [path stringByAppendingPathComponent:@"dataSource.data"];
    [NSKeyedArchiver archiveRootObject:self.dataSource toFile:filePath];
    [self.tableView reloadData];
}

- (void)navigationViewController3:(NavigationViewController3 *)vc saveModel:(ContactModel *)model {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactModel * model = self.dataSource[indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"identifier"];
    }
    cell.imageView.image = model.image;
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.tel;
    return cell;
}

- (IBAction)logoutClick:(UIBarButtonItem *)sender {
//    UIActionSheet * action = [[UIActionSheet alloc]initWithTitle:@"Confirm Logout?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Confirm" otherButtonTitles:nil];
//    [action showInView:self.view];
    
//    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Confirm Logout?" message:@"Click confirm will logout this account..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
//    [alertView show];
#if 0
    typedef NS_ENUM(NSInteger, UIAlertControllerStyle) {
        UIAlertControllerStyleActionSheet = 0,
        UIAlertControllerStyleAlert
    } NS_ENUM_AVAILABLE_IOS(8_0);
    
    typedef NS_ENUM(NSInteger, UIAlertActionStyle) {
        UIAlertActionStyleDefault = 0,
        UIAlertActionStyleCancel,
        UIAlertActionStyleDestructive
    } NS_ENUM_AVAILABLE_IOS(8_0);
#endif
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Confirm Logout?" message:@"Click confirm will logout this account..." preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        UITextField * textField = alert.textFields[0];
//        UITextField * textField2 = alert.textFields[1];
//        NSLog(@"%@ - %@", textField.text, textField2.text);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
//    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.placeholder = @"eg... 1";
//    }];
//    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.placeholder = @"eg... 2";
//    }];
    [self presentViewController:alert animated:YES completion:nil];
}

//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    NSLog(@"%ld", buttonIndex);
//    if (buttonIndex == 0) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == 1) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

@end
