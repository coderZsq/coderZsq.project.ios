//
//  SQPaintView.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQPaintView : UIView

@property (nonatomic,strong) UIColor * lineColor;

@property (nonatomic,assign) CGFloat   lineWidth;

- (void)clear;

- (void)back;

- (void)save;

@end
