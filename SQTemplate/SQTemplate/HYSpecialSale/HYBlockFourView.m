//
//  SubviewTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockFourView.h"
#import "HYBlockFourSubView.h"
#import "HYBlockTitleView.h"

@implementation HYBlockFourView

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

- (HYBlockFourSubView *)blockFourSubView {

    if (!_blockFourSubView) {
        _blockFourSubView = [HYBlockFourSubView new];
    }
    return _blockFourSubView;
}

- (HYBlockTitleView *)blockTitleView {

    if (!_blockTitleView) {
        _blockTitleView = [HYBlockTitleView new];
    }
    return _blockTitleView;
}


- (void)setupSubviews {

    [self addSubview:self.blockFourSubView];
    [self addSubview:self.blockTitleView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat blockTitleViewX = 0;
    CGFloat blockTitleViewY = 0;
    CGFloat blockTitleViewW = self.frame.size.width;
    CGFloat blockTitleViewH = 50;
    _blockTitleView.frame = CGRectMake(blockTitleViewX, blockTitleViewY, blockTitleViewW, blockTitleViewH);
    
    CGFloat blockFourSubViewX = blockTitleViewX;
    CGFloat blockFourSubViewY = blockTitleViewY + blockTitleViewH;
    CGFloat blockFourSubViewW = blockTitleViewW;
    CGFloat blockFourSubViewH = self.frame.size.width;
    _blockFourSubView.frame = CGRectMake(blockFourSubViewX, blockFourSubViewY, blockFourSubViewW, blockFourSubViewH);

}


@end
