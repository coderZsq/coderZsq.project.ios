//
//  DemoController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "DemoController.h"

@interface DemoController ()

@end

@implementation DemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController * vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.view.frame = self.view.bounds;
    self.mainViewController = vc;
}


@end
