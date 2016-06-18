//
//  SQLoadingView.m
//
//  Created by Doubles_Z on 16/6/13.
//  Copyright © 2016年 Doubles_Z. All rights reserved.
//

#import "SQLoadingView.h"

@interface SQLoadingView ()

@property (nonatomic,strong) CAReplicatorLayer * replictorLayer;
@end

@implementation SQLoadingView

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

- (CAReplicatorLayer *)replictorLayer {
    
    if (!_replictorLayer) {
        _replictorLayer = [CAReplicatorLayer layer];
    }
    return _replictorLayer;
}

- (CALayer *)loadingLayer {
    
    if (!_loadingLayer) {
        _loadingLayer = [CALayer layer];
        _loadingLayer.transform = CATransform3DMakeScale(0, 0, 0);
        _loadingLayer.cornerRadius = 2.5;
        _loadingLayer.masksToBounds = YES;
        _loadingLayer.backgroundColor = [UIColor darkGrayColor].CGColor;
    }
    return _loadingLayer;
}

- (void)setupSubviews {
    [self.layer addSublayer:self.replictorLayer];
    [self.replictorLayer addSublayer:self.loadingLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bounds = CGRectMake(0, 0, 30, 30);
    self.center = self.superview.center;
    
    self.replictorLayer.frame = self.bounds;
    self.loadingLayer.position = CGPointMake(self.bounds.size.width * 0.5f, 0);
    self.loadingLayer.bounds = CGRectMake(0, 0, 5, 5);
    
    int count = 15;
    CGFloat angle = M_PI * 2 / count;
    
    self.replictorLayer.instanceCount = count;
    self.replictorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);

    CABasicAnimation * anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale";
    anim.fromValue = @1;
    anim.toValue = @0;
    anim.repeatDuration = MAXFLOAT;
    CGFloat duration = 1;
    anim.duration = duration;
    [self.loadingLayer addAnimation:anim forKey:nil];
    
    self.replictorLayer.instanceDelay = duration / count;
}


@end
