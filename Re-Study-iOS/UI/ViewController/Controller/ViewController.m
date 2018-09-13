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
    
    UIViewController * mainViewController = [[UIStoryboard storyboardWithName:@"MainViewController" bundle:nil] instantiateInitialViewController];
    UIViewController * leftViewController = [[UIStoryboard storyboardWithName:@"TableViewController3" bundle:nil]instantiateInitialViewController];
    self.mainViewController = mainViewController;
    self.leftViewController = leftViewController;
}

@end
