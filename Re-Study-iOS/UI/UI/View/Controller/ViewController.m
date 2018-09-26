//
//  PanSubviewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mainViewController = [[UIStoryboard storyboardWithName:@"MainViewController" bundle:nil] instantiateInitialViewController];;
    self.secondaryViewController = [[UIStoryboard storyboardWithName:@"SecondaryViewController" bundle:nil]instantiateInitialViewController];;
}

@end
