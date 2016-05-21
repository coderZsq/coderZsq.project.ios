//
//  SQPopButton.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQPopButton;

typedef void(^ButtonBlock)(SQPopButton *, NSInteger);

@interface SQPopButton : UIView

- (instancetype)initPopButtonWithSubButtons:(NSInteger)buttonCount
                                totalRadius:(CGFloat)totalRadius
                               centerRadius:(NSInteger)centerRadius
                                  subRadius:(CGFloat)subRadius
                                centerImage:(NSString *)centerImageName
                           centerBackground:(NSString *)centerBackgroundName
                                  subImages:(void(^)(SQPopButton * popButton))imageBlock
                         subImageBackground:(NSString *)subImageBackgroundName
                               toParentView:(UIView *)parentView;

@property (nonatomic) CGFloat   totalRaiuds;
@property (nonatomic) CGFloat   subButtonRadius;
@property (nonatomic) NSInteger subButtonCount;
@property (nonatomic, strong) UIView * parentView;

@property (nonatomic,copy) ButtonBlock block;

- (void)subButtonImage:(NSString *)imageName withTag:(NSInteger)tag;

- (void)collapse;

@end