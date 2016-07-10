//
//  SQLifestylePostButton.m
//  SQLifestyle
//
//  Created by Doubles_Z on 16-6-26.
//  Copyright (c) 2016年 Doubles_Z. All rights reserved.
//

#import "SQLifestylePostButton.h"
#import "SQHoleAnimatedTransitioning.h"
#import "SQNavigationController.h"
#import "SQPostViewController.h"

@interface SQLifestylePostButton () <UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) CAShapeLayer * roundShapeLayer;
@property (nonatomic,strong) CAShapeLayer * horizontalShapeLayer;
@property (nonatomic,strong) CAShapeLayer * verticalShapeLayer;

@end

@implementation SQLifestylePostButton

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

- (CAShapeLayer *)roundShapeLayer {
    
    if (!_roundShapeLayer) {
        _roundShapeLayer = [CAShapeLayer layer];
        _roundShapeLayer.backgroundColor = KC01_57c2de.CGColor;
        _roundShapeLayer.borderColor = KC05_dddddd.CGColor;
        _roundShapeLayer.borderWidth = 0.5f;
        _roundShapeLayer.masksToBounds = YES;
    }
    return _roundShapeLayer;
}

- (CAShapeLayer *)horizontalShapeLayer {
    
    if (!_horizontalShapeLayer) {
        _horizontalShapeLayer = [CAShapeLayer layer];
        _horizontalShapeLayer.fillColor = [UIColor whiteColor].CGColor;
    }
    return _horizontalShapeLayer;
}

- (CAShapeLayer *)verticalShapeLayer {
    
    if (!_verticalShapeLayer) {
        _verticalShapeLayer = [CAShapeLayer layer];
        _verticalShapeLayer.fillColor = _horizontalShapeLayer.fillColor;
    }
    return _verticalShapeLayer;
}

- (void)setupSubviews {
    __weak typeof(self) _self = self;
    [self setAlpha:0.7f];
    [self whenTapped:^{
        SQNavigationController * navigationController = [[SQNavigationController alloc]initWithRootViewController:[SQPostViewController new]];
        [navigationController setTransitioningDelegate:_self];
        [kCurrentViewController presentViewController:navigationController animated:YES completion:nil];
    }];
    [self.layer addSublayer:self.roundShapeLayer];
    [self.layer addSublayer:self.horizontalShapeLayer];
    [self.layer addSublayer:self.verticalShapeLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat roundShapeLayerX = 0;
    CGFloat roundShapeLayerY = 0;
    CGFloat roundShapeLayerW = self.width;
    CGFloat roundShapeLayerH = roundShapeLayerW;
    self.roundShapeLayer.cornerRadius = roundShapeLayerW * 0.5f;
    self.roundShapeLayer.frame = CGRectMake(roundShapeLayerX, roundShapeLayerY, roundShapeLayerW, roundShapeLayerH);
    
    CGFloat horizontalPathW = self.width - 12;
    CGFloat horizontalPathH = self.height / 6;
    CGFloat horizontalPathX = (self.width - horizontalPathW) * 0.5f;
    CGFloat horizontalPathY = (self.height - horizontalPathH) * 0.5f;
    self.horizontalShapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(horizontalPathX, horizontalPathY, horizontalPathW, horizontalPathH) cornerRadius:10].CGPath;
    
    CGFloat verticalPathW = horizontalPathH;
    CGFloat verticalPathH = horizontalPathW;
    CGFloat verticalPathX = (self.width - verticalPathW) * 0.5f;;
    CGFloat verticalPathY = (self.height - horizontalPathW) * 0.5f;;
    self.verticalShapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(verticalPathX, verticalPathY, verticalPathW, verticalPathH) cornerRadius:10].CGPath;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    SQHoleAnimatedTransitioning * animatedTransitioning = [[SQHoleAnimatedTransitioning alloc]init];
    animatedTransitioning.frame = self.frame;
    return animatedTransitioning;
}

@end
