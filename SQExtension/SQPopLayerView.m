//
//  SQPopLayerView.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQPopLayerView.h"

@interface SQPopLayerView ()

@property (nonatomic,strong) UIButton * backgroundButton;
@property (nonatomic,strong) UIView   * popLayer;

@property (nonatomic,assign) CGFloat    popLayerHeight;

@end

@implementation SQPopLayerView

+ (instancetype)viewWithPopLayer:(UIView *)popLayer {

    SQPopLayerView * view = [SQPopLayerView new];
    [view prepareinitializeWithPopLayer:popLayer];
    [view initializeSubviews];
    return view;
}

- (void)prepareinitializeWithPopLayer:(UIView *)popLayer {
    self.frame          = [UIScreen mainScreen].bounds;
    self.popLayer       = popLayer;
    self.popLayerHeight = popLayer.frame.size.height;
}

- (void)initializeSubviews {
    [self addSubview:self.backgroundButton];
    [self addSubview:self.popLayer];
}

- (UIButton *)backgroundButton {
    
    if (!_backgroundButton) {
        _backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backgroundButton.backgroundColor = [UIColor blackColor];
        _backgroundButton.alpha = 0.7f;
        [_backgroundButton addTarget:self action:@selector(removeAllObjects) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroundButton;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backgroundButton setFrame:[UIScreen mainScreen].bounds];
    [self.popLayer setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.popLayerHeight)];
    [self setupEnterAnimation];
}

- (void)setupEnterAnimation {
    [UIView animateWithDuration:0.25f animations:^{
        CGRect popLayerFrame = self.popLayer.frame;
        popLayerFrame.origin.y = self.frame.size.height - self.popLayerHeight;
        self.popLayer.frame = popLayerFrame;
    }];
}

- (void)removeAllObjects {

    [UIView animateWithDuration:0.25 animations:^{
        CGRect popLayerFrame = self.popLayer.frame;
        popLayerFrame.origin.y = self.frame.size.height;
        self.popLayer.frame = popLayerFrame; self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
