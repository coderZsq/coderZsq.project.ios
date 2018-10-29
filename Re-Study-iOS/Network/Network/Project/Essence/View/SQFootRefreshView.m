//
//  SQFootRefreshView.m
//  Network
//
//  Created by 朱双泉 on 2018/10/29.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQFootRefreshView.h"

@interface SQFootRefreshView ()
@property (weak, nonatomic) IBOutlet UIView *refreshView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation SQFootRefreshView

- (void)setIsRefreshing:(BOOL)isRefreshing {
    _isRefreshing = isRefreshing;
    _refreshView.hidden = !isRefreshing;
    _titleLabel.hidden = isRefreshing;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)footView {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
