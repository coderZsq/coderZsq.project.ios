//
//  FriendTrendViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQFriendTrendsViewController.h"

@interface SQFriendTrendsViewController ()

@end

@implementation SQFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"FriendTrends";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highlightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:nil action:nil];
//    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]};
}

- (IBAction)loginButtonClick:(UIButton *)sender {
    [self presentViewController:[[UIStoryboard storyboardWithName:@"SQLoginViewController" bundle:nil] instantiateInitialViewController] animated:YES completion:nil];
}

@end
