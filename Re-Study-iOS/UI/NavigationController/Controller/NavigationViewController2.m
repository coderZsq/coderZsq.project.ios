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
#import "UIImage+Color.h"

#define kOriginalOffsetY -220
#define kOriginalHeight 200

@interface NavigationViewController2 () </*UIActionSheetDelegate, UIAlertViewDelegate*/NavigationViewController3Delegate, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation NavigationViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@'s contacts", self.accountName];
    
    UILabel * titleLabel = [UILabel new];
    titleLabel.text = self.title;
    titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    
    self.view.backgroundColor = BackgroundColor;
    self.tableView.tableFooterView = [UIView new];
#if 0
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.alpha = 0;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Resize"] forBarMetrics:UIBarMetricsDefault]; //UIBarMetricsCompact
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.tableView setContentInset:UIEdgeInsetsMake(-Top, 0, 0, 0)];
    
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(0, 0, 0, 200);
    self.tableView.tableHeaderView = view;
#endif
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    [self.tableView setContentInset:UIEdgeInsetsMake(-(kOriginalOffsetY + Top), 0, 0, 0)];
    [self.tableView setContentOffset:CGPointMake(0, kOriginalOffsetY + Top)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@", NSStringFromCGRect(self.tableView.frame));
    NSLog(@"%@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
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

- (void)archiveDataSource {
    NSString * path =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString * filePath = [path stringByAppendingPathComponent:@"dataSource.data"];
    [NSKeyedArchiver archiveRootObject:self.dataSource toFile:filePath];
}

- (void)navigationViewController3:(NavigationViewController3 *)vc addModel:(ContactModel *)model {
    [self.dataSource addObject:model];
    [self archiveDataSource];
    [self.tableView reloadData];
}

- (void)navigationViewController3:(NavigationViewController3 *)vc saveModel:(ContactModel *)model {
    [self archiveDataSource];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f", scrollView.contentOffset.y);
    CGFloat offset = scrollView.contentOffset.y - kOriginalOffsetY;
    CGFloat height = kOriginalHeight - offset;
    if (height <= Top) {
        height = Top;
    }
    self.heightConstraint.constant = height;
    
    CGFloat alpha = offset * 1 / (kOriginalHeight - Top);
    if (alpha >= 1) {
        alpha = .99;
    }
    UIColor * color = [UIColor colorWithWhite:1. alpha:alpha];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    UILabel * titleLabel = (UILabel *)self.navigationItem.titleView;
    titleLabel.textColor = [UIColor colorWithWhite:.0 alpha:alpha];
    [self.logoutButton setTitleColor:[SystemColor colorWithAlphaComponent:alpha] forState:UIControlStateNormal];
    [self.addButton setTitleColor:[SystemColor colorWithAlphaComponent:alpha] forState:UIControlStateNormal];
}

- (IBAction)logoutButtonClick:(UIButton *)sender {
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
