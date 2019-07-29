//
//  SQLoadingView.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/14.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQLoadingView.h"

@interface SQLoadingView ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation SQLoadingView

+ (instancetype)loadingView {
    SQLoadingView *loadingView =[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(SQLoadingView.class) owner:nil options:nil].firstObject;
    loadingView.indicatorView.color = [UIColor lightGrayColor];
    return loadingView;
}

- (void)show {
    [self.indicatorView startAnimating];
    self.hidden = NO;
}

- (void)hide {
    [self.indicatorView stopAnimating];
    self.hidden = YES;
}

@end
