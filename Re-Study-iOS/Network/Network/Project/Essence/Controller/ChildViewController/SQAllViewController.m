//
//  SQAllViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQAllViewController.h"
#import "SQTopicCell.h"

@interface SQAllViewController ()

@end

@implementation SQAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[SQTopicCell class] forCellReuseIdentifier:@"reuseIdentifier"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SQTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    return cell;
}

@end
