//
//  SQHeadRefreshView.m
//  Network
//
//  Created by 朱双泉 on 2018/10/29.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQHeadRefreshView.h"

@interface SQHeadRefreshView ()
@property (weak, nonatomic) IBOutlet UIView *refreshView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation SQHeadRefreshView

- (void)setIsRefreshing:(BOOL)isRefreshing {
    _isRefreshing = isRefreshing;
    _refreshView.hidden = !isRefreshing;
    _titleLabel.hidden = isRefreshing;
}

- (void)setIsNeedLoad:(BOOL)isNeedLoad {
    _isNeedLoad = isNeedLoad;
    _titleLabel.text = isNeedLoad ? @"松开立即刷新" : @"上拉可以刷新";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)headView {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
