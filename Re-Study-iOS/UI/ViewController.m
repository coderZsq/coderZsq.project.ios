//
//  ViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ViewController.h"
#import "BasicControlViewController.h"
#import "ScrollViewController.h"

@interface ViewController ()
@property (nonatomic, copy) NSArray * dataSource;
@end

@implementation ViewController

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = @[[BasicControlViewController class],
                        [ScrollViewController class]];
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
    }
    cell.textLabel.text = NSStringFromClass(self.dataSource[indexPath.row]);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[self.dataSource[indexPath.row] new] animated:YES];
}

@end
