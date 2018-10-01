//
//  ViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/9/26.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ViewController.h"
#import "Thread/ThreadViewController.h"
#import "WebImage/WebImageViewController.h"
#import "NetWork/NetWorkViewController.h"
#import "Download/DownloadViewController.h"
#import "Security/SecurityViewController.h"
#import "WebView/WebViewController.h"

@interface ViewController ()
@property (nonatomic, copy) NSArray * dataSource;
@end

@implementation ViewController

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = @[@{@"classes" : @[[ThreadViewController class],
                                         [WebImageViewController class]],
                          @"titleheader" : @"multi-thread",
                          @"titlefooter" : @"Some examples of multi-thread learning."},
                        @{@"classes" : @[[NetWorkViewController class],
                                         [DownloadViewController class],
                                         [SecurityViewController class],
                                         [WebViewController class]],
                          @"titleheader" : @"networking",
                          @"titlefooter" : @"Some examples of networking learning."}];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

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
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"identifier"];
        cell.imageView.image = [UIImage imageNamed:@"Mark"];
    }
    cell.textLabel.text = NSStringFromClass(self.dataSource[indexPath.section][@"classes"][indexPath.row]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:NSStringFromClass(self.dataSource[indexPath.section][@"classes"][indexPath.row]) bundle:nil]instantiateInitialViewController] animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.dataSource[section][@"titleheader"];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return self.dataSource[section][@"titlefooter"];
}

/*
 $ svn checkout http:...... --username=... --password=...
 $ svn status
 $ svn add ... | *
 $ svn commit -m "..."
 */

/*
 $ svn remove ...
 $ svn commit -m "..." ...?
 */

/*
 $ svn update
 $ svn log
 */

/*
 p | df | mc | tc
 $ svn resolved ...
 $ svn commit -m "..." ...?
 */

/*
 $ svn revert ...
 
 $ svn update -r..
 $ svn update
 $ svn merge -r..:-r.. ...
 $ svn commit -m "..." ...?
 */

/*
 checkout -> co
 status -> st
 commit -> ci
 remove -> rm
 update -> up
 */

@end
