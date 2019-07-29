//
//  SQType1SubCell.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/12.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQType1SubCell.h"
#import "UIView+SQExtension.h"
#import "NSObject+SQExtension.h"
#import "SQMagnetViewController.h"

@implementation SQType1SubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.layer.borderWidth = 1;
    self.imageView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.3].CGColor;
    
    __weak typeof(self) weakSelf = self;
    [self whenTapped:^{
        SQMagnetViewController *magnetVC = [[UIStoryboard storyboardWithName:NSStringFromClass(SQMagnetViewController.class) bundle:nil] instantiateInitialViewController];
        magnetVC.query = weakSelf.titleLabel.text;
        magnetVC.rate = weakSelf.rateLabel.text;
        magnetVC.image = weakSelf.imageView.image;
        [[weakSelf getCurrentViewController] presentViewController:magnetVC animated:YES completion:nil];
    }];
}

@end
