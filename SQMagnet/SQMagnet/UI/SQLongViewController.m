//
//  SQLongViewController.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/18.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQLongViewController.h"
#import "UIColor+SQExtension.h"

@interface SQLongViewController ()

@end

@implementation SQLongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hookApplicationWillEnterForeground];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:self.imageNamed];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat imageViewHeight = screenWidth * image.size.height / image.size.width;
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    imageView.frame = CGRectMake(0, 0, screenWidth, imageViewHeight);
    [scrollView addSubview: imageView];
    scrollView.contentSize = imageView.bounds.size;
    [self.view addSubview:scrollView];
}

- (void)hookApplicationWillEnterForeground {
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return [UIColor colorWithHexString:@"#1c1c1e"];
            } else {
                return [UIColor whiteColor];
            }
        }];
    }
}

@end
