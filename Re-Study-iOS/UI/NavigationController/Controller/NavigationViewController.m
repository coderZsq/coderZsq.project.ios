//
//  NavigationViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)backBarButtonItemClick:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
