//
//  SubviewTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockTwoView.h"
#import "HYBlockTitleView.h"
#import "HYBlockTwoSubView.h"

@implementation HYBlockTwoView

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

- (HYBlockTitleView *)blockTitleView {

    if (!_blockTitleView) {
        _blockTitleView = [HYBlockTitleView new];
    }
    return _blockTitleView;
}

- (HYBlockTwoSubView *)blockTwoSubView {

    if (!_blockTwoSubView) {
        _blockTwoSubView = [HYBlockTwoSubView new];
    }
    return _blockTwoSubView;
}


- (void)setupSubviews {

    [self addSubview:self.blockTitleView];
    [self addSubview:self.blockTwoSubView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat blockTitleViewX = 0;
    CGFloat blockTitleViewY = 0;
    CGFloat blockTitleViewW = self.frame.size.width;
    CGFloat blockTitleViewH = 50;
    _blockTitleView.frame = CGRectMake(blockTitleViewX, blockTitleViewY, blockTitleViewW, blockTitleViewH);

    CGFloat blockTwoSubViewX = 0;
    CGFloat blockTwoSubViewY = blockTitleViewY + blockTitleViewH;
    CGFloat blockTwoSubViewW = blockTitleViewW;
    CGFloat blockTwoSubViewH = 120;
    _blockTwoSubView.frame = CGRectMake(blockTwoSubViewX, blockTwoSubViewY, blockTwoSubViewW, blockTwoSubViewH);


}


@end
