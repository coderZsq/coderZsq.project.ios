//
//  SubviewTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockFiveView.h"
#import "HYBlockFiveSubView.h"
#import "HYBlockTitleView.h"

@implementation HYBlockFiveView

- (void)dealloc {
    NSLog(@"%@ - execute %s",NSStringFromClass([self class]),__func__);
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder  {
    
    self = [super initWithCoder:coder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (HYBlockFiveSubView *)blockFiveSubView {

    if (!_blockFiveSubView) {
        _blockFiveSubView = [HYBlockFiveSubView new];
    }
    return _blockFiveSubView;
}

- (HYBlockTitleView *)blockTitleView {

    if (!_blockTitleView) {
        _blockTitleView = [HYBlockTitleView new];
    }
    return _blockTitleView;
}


- (void)setupSubviews {

    [self addSubview:self.blockFiveSubView];
    [self addSubview:self.blockTitleView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat blockTitleViewX = 0;
    CGFloat blockTitleViewY = 0;
    CGFloat blockTitleViewW = self.frame.size.width;
    CGFloat blockTitleViewH = 50;
    _blockTitleView.frame = CGRectMake(blockTitleViewX, blockTitleViewY, blockTitleViewW, blockTitleViewH);
    
    CGFloat blockFiveSubViewX = blockTitleViewX;
    CGFloat blockFiveSubViewY = blockTitleViewY + blockTitleViewH;
    CGFloat blockFiveSubViewW = blockTitleViewW;
    CGFloat blockFiveSubViewH = self.frame.size.width + 100;
    _blockFiveSubView.frame = CGRectMake(blockFiveSubViewX, blockFiveSubViewY, blockFiveSubViewW, blockFiveSubViewH);

}


@end
