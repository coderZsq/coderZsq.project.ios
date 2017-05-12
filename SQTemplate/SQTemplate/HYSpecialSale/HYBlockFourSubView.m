//
//  SubviewTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockFourSubView.h"

@implementation HYBlockFourSubView

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

- (UIButton *)leftTopButton {

    if (!_leftTopButton) {
        _leftTopButton = [UIButton new];
        _leftTopButton.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];
    }
    return _leftTopButton;
}

- (UIButton *)leftBottomButton {

    if (!_leftBottomButton) {
        _leftBottomButton = [UIButton new];
        _leftBottomButton.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];
    }
    return _leftBottomButton;
}

- (UIButton *)rightTopButton {

    if (!_rightTopButton) {
        _rightTopButton = [UIButton new];
        _rightTopButton.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];
    }
    return _rightTopButton;
}

- (UIButton *)rightBottomButton {

    if (!_rightBottomButton) {
        _rightBottomButton = [UIButton new];
        _rightBottomButton.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];
    }
    return _rightBottomButton;
}


- (void)setupSubviews {

    [self addSubview:self.leftTopButton];
    [self addSubview:self.leftBottomButton];
    [self addSubview:self.rightTopButton];
    [self addSubview:self.rightBottomButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat leftTopButtonX = 0;
    CGFloat leftTopButtonY = 0;
    CGFloat leftTopButtonW = self.frame.size.width / 2;
    CGFloat leftTopButtonH = leftTopButtonW;
    _leftTopButton.frame = CGRectMake(leftTopButtonX, leftTopButtonY, leftTopButtonW, leftTopButtonH);

    CGFloat leftBottomButtonX = leftTopButtonX;
    CGFloat leftBottomButtonY = leftTopButtonY + leftTopButtonH;
    CGFloat leftBottomButtonW = leftTopButtonW;
    CGFloat leftBottomButtonH = leftTopButtonH;
    _leftBottomButton.frame = CGRectMake(leftBottomButtonX, leftBottomButtonY, leftBottomButtonW, leftBottomButtonH);

    CGFloat rightTopButtonX = leftTopButtonX + leftTopButtonW;
    CGFloat rightTopButtonY = leftTopButtonY;
    CGFloat rightTopButtonW = leftBottomButtonW;
    CGFloat rightTopButtonH = leftBottomButtonH;
    _rightTopButton.frame = CGRectMake(rightTopButtonX, rightTopButtonY, rightTopButtonW, rightTopButtonH);

    CGFloat rightBottomButtonX = rightTopButtonX;
    CGFloat rightBottomButtonY = leftBottomButtonY;
    CGFloat rightBottomButtonW = leftBottomButtonW;
    CGFloat rightBottomButtonH = leftBottomButtonH;
    _rightBottomButton.frame = CGRectMake(rightBottomButtonX, rightBottomButtonY, rightBottomButtonW, rightBottomButtonH);


}


@end
