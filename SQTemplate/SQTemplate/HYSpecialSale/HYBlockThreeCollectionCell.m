//
//  CollectionViewCellTemplate.m
//  SQTemplate/Users/Doubles_Z/Desktop/SQTemplate/SQTemplate/UITemplate
//
//  Created by 双泉 朱 on 17/5/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "HYBlockThreeCollectionCell.h"

@interface HYBlockThreeCollectionCell ()

@property (nonatomic,strong) UIButton * imageButton;

@end

@implementation HYBlockThreeCollectionCell

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

- (UIButton *)imageButton {

    if (!_imageButton) {
        _imageButton = [UIButton new];
    }
    return _imageButton;
}

- (void)setupSubviews {
    [self addSubview:self.imageButton];
}

- (void)setAdapter:(id<HYBlockThreeCollectionCellAdapter>)adapter {
    _adapter = adapter;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imageButtonX = 0;
    CGFloat imageButtonY = 0;
    CGFloat imageButtonW = self.frame.size.width;
    CGFloat imageButtonH = self.frame.size.height;
    _imageButton.frame = CGRectMake(imageButtonX, imageButtonY, imageButtonW, imageButtonH);

}

@end
