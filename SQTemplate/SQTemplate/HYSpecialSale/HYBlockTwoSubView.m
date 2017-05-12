//
//  SubviewTemplate.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockTwoSubView.h"

@implementation HYBlockTwoSubView

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

- (UIButton *)backgroundButton {

    if (!_backgroundButton) {
        _backgroundButton = [UIButton new];
        _backgroundButton.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];
    }
    return _backgroundButton;
}


- (void)setupSubviews {

    [self addSubview:self.backgroundButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat backgroundButtonX = 0;
    CGFloat backgroundButtonY = 0;
    CGFloat backgroundButtonW = self.frame.size.width;
    CGFloat backgroundButtonH = self.frame.size.height;
    _backgroundButton.frame = CGRectMake(backgroundButtonX, backgroundButtonY, backgroundButtonW, backgroundButtonH);

}


@end
