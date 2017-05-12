//
//  SubviewTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockOneView.h"
#import "HYBlockOneSubView.h"
#import "HYBlockTitleView.h"

@implementation HYBlockOneView

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

- (HYBlockOneSubView *)blockOneSubView {

    if (!_blockOneSubView) {
        _blockOneSubView = [HYBlockOneSubView new];
    }
    return _blockOneSubView;
}

- (HYBlockTitleView *)blockTitleView {

    if (!_blockTitleView) {
        _blockTitleView = [HYBlockTitleView new];
    }
    return _blockTitleView;
}


- (void)setupSubviews {

    [self addSubview:self.blockOneSubView];
    [self addSubview:self.blockTitleView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat blockTitleViewX = 0;
    CGFloat blockTitleViewY = 0;
    CGFloat blockTitleViewW = self.frame.size.width;
    CGFloat blockTitleViewH = 50;
    _blockTitleView.frame = CGRectMake(blockTitleViewX, blockTitleViewY, blockTitleViewW, blockTitleViewH);
    
    CGFloat blockOneSubViewX = blockTitleViewX;
    CGFloat blockOneSubViewY = blockTitleViewY + blockTitleViewH;
    CGFloat blockOneSubViewW = blockTitleViewW;
    CGFloat blockOneSubViewH = 140;
    _blockOneSubView.frame = CGRectMake(blockOneSubViewX, blockOneSubViewY, blockOneSubViewW, blockOneSubViewH);

}


@end
