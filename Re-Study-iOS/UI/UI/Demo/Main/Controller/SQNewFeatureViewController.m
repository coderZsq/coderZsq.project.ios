//
//  SQNewFeatureViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/25.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQNewFeatureViewController.h"

@interface SQNewFeatureViewController ()

@end

@implementation SQNewFeatureViewController

- (void)loadView {
    [super loadView];
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"music"]];
    imageView.width = 34;
    imageView.height = 34;
    imageView.x = ScreenWidth - imageView.width - 10;
    imageView.y = Top + 5;
    imageView.layer.cornerRadius = 17;
    imageView.layer.masksToBounds = YES;
    imageView.userInteractionEnabled = YES;
    UIButton * button = [UIButton new];
    button.frame = imageView.bounds;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:button];
    [self.view addSubview:imageView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.25 animations:^{
            imageView.alpha = .0;
        }completion:^(BOOL finished) {
            [self buttonClick:button];
        }];
    });
}

- (void)buttonClick:(UIButton *)sender {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
