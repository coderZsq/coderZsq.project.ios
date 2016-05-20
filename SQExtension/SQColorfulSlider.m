//
//  SQColorfulSlider.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQColorfulSlider.h"

static const CGFloat offset = 2;

@interface SQColorfulSlider ()

@property (nonatomic,strong) UISlider       * slider ;
@property (nonatomic,strong) UIProgressView * progressView;
@property (nonatomic,strong) id target;
@property (nonatomic,assign) SEL action;
@property (nonatomic,assign,getter = isLoaded) BOOL loaded;

@end

@implementation SQColorfulSlider

- (void)awakeFromNib {
    [self loadSubView];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubView];
    }
    return self;
}

- (void)loadSubView {
    
    if (_loaded) return;
    _loaded = YES;
    
    self.backgroundColor = [UIColor clearColor];
    
    _slider = [[UISlider alloc] initWithFrame:self.bounds];
    _slider.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:_slider];

    CGRect rect = _slider.bounds;
    rect.origin.x   += offset;
    rect.size.width -= offset * 2;
    
    _progressView = [[UIProgressView alloc] initWithFrame:rect];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _progressView.center = _slider.center;
    _progressView.userInteractionEnabled = NO;

    [_slider addSubview:_progressView];
    [_slider sendSubviewToBack:_progressView];
    
    _slider.maximumTrackTintColor = [UIColor clearColor];
}

- (CGFloat)value {
    return _slider.value;
}

- (void)setValue:(CGFloat)value {
    _slider.value = value;
}

- (CGFloat)middleValue {
    return _progressView.progress;
}

- (void)setMiddleValue:(CGFloat)middleValue {
    _progressView.progress = middleValue;
}

- (UIColor *)minimumTrackTintColor {
    return _slider.minimumTrackTintColor;
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    [_slider setMinimumTrackTintColor:minimumTrackTintColor];
}

- (UIColor* )middleTrackTintColor {
    return _progressView.progressTintColor;
}

- (void)setMiddleTrackTintColor:(UIColor *)middleTrackTintColor {
    _progressView.progressTintColor = middleTrackTintColor;
}

- (UIColor* )maximumTrackTintColor {
    return _progressView.trackTintColor;
}

- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    _progressView.trackTintColor = maximumTrackTintColor;
}

@end
