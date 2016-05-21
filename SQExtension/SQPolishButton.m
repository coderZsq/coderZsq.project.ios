//
//  SQPolishButton.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQPolishButton.h"

@interface SQPolishButton ()

@property (nonatomic,strong) CAGradientLayer * gradientLayer;

@end

@implementation SQPolishButton

- (instancetype)initWithFrame:(CGRect)frame withColor:(UIColor *)color {
    
    if ([super initWithFrame:frame]) {
        [self setColor:color];
        [self makeButtonPolish:self withBackgroundColor:color];
        [self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (CAGradientLayer *)gradientLayer {
    
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
    }
    return _gradientLayer;
}

- (void)setColor:(UIColor *)color {
    _color = color; [self makeButtonPolish:self withBackgroundColor:color];
}

- (void)makeButtonPolish:(SQPolishButton *)button withBackgroundColor:(UIColor *)backgroundColor {
    
    CALayer * layer      = button.layer;
    layer.cornerRadius  = 8.0f;
    layer.masksToBounds = YES;
    layer.borderWidth   = 2.0f;
    layer.borderColor   = [UIColor colorWithWhite:0.4f alpha:0.2f].CGColor;
    
    self.gradientLayer.frame     = button.layer.bounds;
    self.gradientLayer.locations = @[@0.0f,@0.5f,@0.5f,@0.8f,@1.0f];
    self.gradientLayer.colors    = [NSArray arrayWithObjects:
                               (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                               (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                               (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                               (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                               (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                               nil];
    [self.layer addSublayer:self.gradientLayer];
    [button setBackgroundColor:backgroundColor];
}


- (void)touchDown {
    
    UIColor * polishColor;
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0, white = 0.0;
    if ([self.color respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self.color getRed:&red green:&green blue:&blue alpha:&alpha];
        [self.color getWhite:&white alpha:&alpha];

        if(!(red + green + blue) && white){
            polishColor = [UIColor colorWithWhite:white - 0.2 alpha:alpha];
        } else if(!(red + green + blue) && !white) {
            polishColor = [UIColor colorWithWhite:white + 0.2 alpha:alpha];
        } else{
            polishColor = [UIColor colorWithRed:red - 0.2 green:green - 0.2 blue:blue - 0.2 alpha:alpha];
        }
    }
    self.backgroundColor = polishColor;
    
}

- (void)touchUpInside {
    
    self.backgroundColor = self.color;
    if (self.operation) {
        self.operation();
    }
}

@end
