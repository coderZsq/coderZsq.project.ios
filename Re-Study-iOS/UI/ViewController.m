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
#import "PickerViewController.h"
#import "NavigationController.h"

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
    //    UIView * view = nil;
    //    if (!view) {
    //        view = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateInitialViewController].view;
    //    } else if (!view) {
    //        view = [[[NSBundle mainBundle]loadNibNamed:@"ViewController" owner:nil options:nil]firstObject];
    //    } else if (!view) {
    //        view = [UIView new];
    //    }
    //    self.view = view;
    [super loadView];
}
#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UI";
}

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = @[@{@"classes" : @[[BasicControlController class],
                                         [ScrollViewController class],
                                         [TableViewController class]],
                          @"titleheader" : @"basic",
                          @"titlefooter" : @"Some examples of basic user interaction learning."},
                        @{@"classes" : @[[PickerViewController class],
                                         [NavigationController class]],
                          @"titleheader" : @"advanced",
                          @"titlefooter" : @"Some examples of advanced user interaction learning."}];
    }
    return _dataSource;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section][@"classes"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:@"Mark"];
    }
    cell.textLabel.text = NSStringFromClass(self.dataSource[indexPath.section][@"classes"][indexPath.row]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray * classes = self.dataSource[indexPath.section][@"classes"];
    UIViewController * vc = nil;
    UIStoryboard * sb = nil;
    @try {
        sb = [UIStoryboard storyboardWithName:NSStringFromClass(classes[indexPath.row]) bundle:nil];
    } @catch (NSException *exception)  {
        NSLog(@"%@", exception);
    } @finally {
        if (sb) vc = [sb instantiateInitialViewController];
        else vc = [classes[indexPath.row] new];
        if ([vc isKindOfClass:[UINavigationController class]])
            [self presentViewController:vc animated:YES completion:nil];
        else [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.dataSource[section][@"titleheader"];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return self.dataSource[section][@"titlefooter"];
}

@end
