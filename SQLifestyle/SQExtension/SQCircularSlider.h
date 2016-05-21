//
//  SQCircularSlider.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQCircularSlider : UIControl

@property (nonatomic, assign) float value;

@property (nonatomic, assign) float minimumValue;

@property (nonatomic, assign) float maximumValue;

@property (nonatomic, assign) float lineWidth;

@property (nonatomic, assign) float thumbRadius;

@property (nonatomic, strong) UIColor * minimumTrackTintColor;

@property (nonatomic, strong) UIColor * maximumTrackTintColor;

@property (nonatomic, strong) UIColor * thumbTintColor;

@end

