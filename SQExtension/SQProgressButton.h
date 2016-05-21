//
//  SQProgressButton.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQProgressButton : UIButton

@property (nonatomic, assign) float progress;

@property (nonatomic, assign) float startAngle;

@property (nonatomic, strong) UIColor *tintColor ;

@property (nonatomic, strong) UIColor *trackColor;

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
