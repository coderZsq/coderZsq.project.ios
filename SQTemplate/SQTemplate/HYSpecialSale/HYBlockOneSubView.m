//
//  SubviewTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockOneSubView.h"

@implementation HYBlockOneSubView

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

- (UIButton *)leftButton {

    if (!_leftButton) {
        _leftButton = [UIButton new];
        _leftButton.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];
    }
    return _leftButton;
}

- (UIButton *)rightBottomButton {

    if (!_rightBottomButton) {
        _rightBottomButton = [UIButton new];
        _rightBottomButton.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];
    }
    return _rightBottomButton;
}

- (UIButton *)rightTopButton {

    if (!_rightTopButton) {
        _rightTopButton = [UIButton new];
        _rightTopButton.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];
    }
    return _rightTopButton;
}


- (void)setupSubviews {

    [self addSubview:self.leftButton];
    [self addSubview:self.rightBottomButton];
    [self addSubview:self.rightTopButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat leftButtonX = 0;
    CGFloat leftButtonY = 0;
    CGFloat leftButtonW = self.frame.size.width / 2;
    CGFloat leftButtonH = self.frame.size.height;
    _leftButton.frame = CGRectMake(leftButtonX, leftButtonY, leftButtonW, leftButtonH);

    CGFloat rightBottomButtonX = leftButtonX + leftButtonW;
    CGFloat rightBottomButtonY = leftButtonY;
    CGFloat rightBottomButtonW = leftButtonW;
    CGFloat rightBottomButtonH = leftButtonH / 2;
    _rightBottomButton.frame = CGRectMake(rightBottomButtonX, rightBottomButtonY, rightBottomButtonW, rightBottomButtonH);

    CGFloat rightTopButtonX = rightBottomButtonX;
    CGFloat rightTopButtonY = rightBottomButtonY + rightBottomButtonH;
    CGFloat rightTopButtonW = rightBottomButtonW;
    CGFloat rightTopButtonH = rightBottomButtonH;
    _rightTopButton.frame = CGRectMake(rightTopButtonX, rightTopButtonY, rightTopButtonW, rightTopButtonH);


}


@end
