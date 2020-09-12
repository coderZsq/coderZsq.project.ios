//
//  ViewController.m
//  SQNumbers
//
//  Created by 朱双泉 on 2020/9/12.
//  Copyright © 2020 朱双泉. All rights reserved.
//

#import "ViewController.h"
#import "SQSceneView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SQSceneView *sceneView = [SQSceneView new];
    sceneView.frame = self.view.bounds;
    sceneView.capacity = arc4random() % 6;
    [sceneView renderToCanvas:self.view];
    
}

@end
