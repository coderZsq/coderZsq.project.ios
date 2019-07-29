//
//  SQDisclaimerViewController.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/19.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQDisclaimerViewController.h"
#import "SQType3Cell.h"

@interface SQDisclaimerViewController ()

@end

@implementation SQDisclaimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(SQType3Cell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(SQType3Cell.class)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SQType3Cell.class)];
}

@end
