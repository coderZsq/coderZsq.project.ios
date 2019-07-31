//
//  SQConnectViewController.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/18.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQConnectViewController.h"
#import "UIColor+SQExtension.h"

@interface SQConnectViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation SQConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hookApplicationWillEnterForeground];
    self.imageView.image = [UIImage imageNamed:self.imageNamed];
}

- (void)hookApplicationWillEnterForeground {
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return [UIColor colorWithHexString:@"#1c1c1e"];
            } else {
                return [UIColor colorWithHexString:@"#f8f8f8"];
            }
        }];
    }
}

@end
