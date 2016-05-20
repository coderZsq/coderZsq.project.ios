//
//  SQProgressLayer.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface SQProgressLayer : CALayer

@property (nonatomic, assign) float progress;

@property (nonatomic, assign) float startAngle;

@property (nonatomic, strong) UIColor * tintColor;

@property (nonatomic, strong) UIColor * trackColor;

@end
