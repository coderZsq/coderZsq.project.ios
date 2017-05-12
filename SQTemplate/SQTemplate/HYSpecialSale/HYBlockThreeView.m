//
//  SubviewTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockThreeView.h"
#import "HYBlockThreeSubView.h"
#import "HYBlockTitleView.h"

@implementation HYBlockThreeView

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

- (HYBlockThreeSubView *)blockThreeSubView {

    if (!_blockThreeSubView) {
        _blockThreeSubView = [HYBlockThreeSubView new];
    }
    return _blockThreeSubView;
}

- (HYBlockTitleView *)blockTitleView {

    if (!_blockTitleView) {
        _blockTitleView = [HYBlockTitleView new];
    }
    return _blockTitleView;
}


- (void)setupSubviews {

    [self addSubview:self.blockThreeSubView];
    [self addSubview:self.blockTitleView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat blockTitleViewX = 0;
    CGFloat blockTitleViewY = 0;
    CGFloat blockTitleViewW = self.frame.size.width;
    CGFloat blockTitleViewH = 50;
    _blockTitleView.frame = CGRectMake(blockTitleViewX, blockTitleViewY, blockTitleViewW, blockTitleViewH);
    
    CGFloat blockThreeSubViewX = blockTitleViewX;
    CGFloat blockThreeSubViewY = blockTitleViewY + blockTitleViewH;
    CGFloat blockThreeSubViewW = blockTitleViewW;
    CGFloat blockThreeSubViewH = 220;
    _blockThreeSubView.frame = CGRectMake(blockThreeSubViewX, blockThreeSubViewY, blockThreeSubViewW, blockThreeSubViewH);

}


@end
