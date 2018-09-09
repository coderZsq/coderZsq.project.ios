//
//  ViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ViewController.h"
#import "BasicControlController.h"
#import "ScrollViewController.h"
#import "TableViewController.h"

@interface ViewController ()
@property (nonatomic, copy) NSArray * dataSource;
@end

@implementation ViewController
#if 0
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIView *)view {
    
    if (!_view) {
        [self loadView];
        [self viewDidLoad];
    }
    return _view;
}

- (void)loadView {
    UIView * view = nil;
    if (!view) {
        view = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateInitialViewController].view;
    } else if (!view) {
        view = [[[NSBundle mainBundle]loadNibNamed:@"ViewController" owner:nil options:nil]firstObject];
    } else if (!view) {
        view = [UIView new];
    }
    self.view = view;
    [super loadView];
}
#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UI";
}

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = @[[BasicControlController class],
                        [ScrollViewController class],
                        [TableViewController class]];
    }
    return _dataSource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:@"Mark"];
    }
    cell.textLabel.text = NSStringFromClass(self.dataSource[indexPath.row]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[self.dataSource[indexPath.row] new] animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"basic";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"Some examples of basic user interaction learning.";
}

@end
