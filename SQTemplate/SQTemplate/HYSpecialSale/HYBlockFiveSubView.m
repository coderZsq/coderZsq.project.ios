//
//  SubviewTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockFiveSubView.h"

@implementation HYBlockFiveSubView

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

- (UIButton *)mainButton {

    if (!_mainButton) {
        _mainButton = [UIButton new];
        _mainButton.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];

    }
    return _mainButton;
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

- (UIButton *)leftTopButton {

    if (!_leftTopButton) {
        _leftTopButton = [UIButton new];
        _leftTopButton.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];
    }
    return _leftTopButton;
}


- (void)setupSubviews {

    [self addSubview:self.mainButton];
    [self addSubview:self.leftBottomButton];
    [self addSubview:self.rightTopButton];
    [self addSubview:self.rightBottomButton];
    [self addSubview:self.leftTopButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat mainButtonX = 0;
    CGFloat mainButtonY = 0;
    CGFloat mainButtonW = self.frame.size.width;
    CGFloat mainButtonH = 100;
    _mainButton.frame = CGRectMake(mainButtonX, mainButtonY, mainButtonW, mainButtonH);

    CGFloat leftTopButtonX = 0;
    CGFloat leftTopButtonY = mainButtonY + mainButtonH;
    CGFloat leftTopButtonW = self.frame.size.width / 2;
    CGFloat leftTopButtonH = leftTopButtonW;
    _leftTopButton.frame = CGRectMake(leftTopButtonX, leftTopButtonY, leftTopButtonW, leftTopButtonH);
    
    CGFloat leftBottomButtonX = leftTopButtonX;
    CGFloat leftBottomButtonY = leftTopButtonY + leftTopButtonH;
    CGFloat leftBottomButtonW = leftTopButtonW;
    CGFloat leftBottomButtonH = leftTopButtonW;
    _leftBottomButton.frame = CGRectMake(leftBottomButtonX, leftBottomButtonY, leftBottomButtonW, leftBottomButtonH);

    CGFloat rightTopButtonX = leftTopButtonX + leftTopButtonW;
    CGFloat rightTopButtonY = leftTopButtonY;
    CGFloat rightTopButtonW = leftTopButtonW;
    CGFloat rightTopButtonH = leftTopButtonW;
    _rightTopButton.frame = CGRectMake(rightTopButtonX, rightTopButtonY, rightTopButtonW, rightTopButtonH);

    CGFloat rightBottomButtonX = rightTopButtonX;
    CGFloat rightBottomButtonY = rightTopButtonY + rightTopButtonH;
    CGFloat rightBottomButtonW = leftTopButtonW;
    CGFloat rightBottomButtonH = leftTopButtonW;
    _rightBottomButton.frame = CGRectMake(rightBottomButtonX, rightBottomButtonY, rightBottomButtonW, rightBottomButtonH);
}


@end
