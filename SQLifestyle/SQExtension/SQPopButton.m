//
//  SQPopButton.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQPopButton.h"

@interface SQPopButton ()

@property (nonatomic,strong) UIButton * centerButton;
@property (nonatomic,strong) UIButton * subButton;

@property (nonatomic,assign) CGPoint birthLocation;

@property (nonatomic,strong) NSMutableArray * subButtonsArrM;
@property (nonatomic,strong) NSMutableArray * appearLocationArrM;

@property (nonatomic, getter = isExpanded) BOOL expanded;

@end

@implementation SQPopButton

- (instancetype)initPopButtonWithSubButtons:(NSInteger)buttonCount totalRadius:(CGFloat)totalRadius centerRadius:(NSInteger)centerRadius subRadius:(CGFloat)subRadius centerImage:(NSString *)centerImageName centerBackground:(NSString *)centerBackgroundName subImages:(void (^)(SQPopButton *))imageBlock subImageBackground:(NSString *)subImageBackgroundName toParentView:(UIView *)parentView {
    
    self.parentView = parentView;
    self.subButtonCount = buttonCount;
    self.totalRaiuds = totalRadius;
    self.subButtonRadius = subRadius;
    self.expanded = NO;
    self.birthLocation = CGPointMake(-self.parentView.frame.size.width * 0.5f, -self.parentView.frame.size.height * 0.5f);
    
    if (self = [super init]) {
        [self configureCenterButton:centerRadius image:centerImageName backgroundImage:centerBackgroundName];
        [self configureSubButtons:buttonCount];
        imageBlock(self);
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.appearLocationArrM = [NSMutableArray array];
    for (int i = 0 ; i < self.subButtonCount; i++) {
        [self.appearLocationArrM addObject:[NSValue valueWithCGPoint:CGPointMake(self.frame.size.width * 0.5f + self.totalRaiuds * cosf(i * ( M_PI * 2 / self.subButtonCount)), self.frame.size.width * 0.5f - self.totalRaiuds * sinf(i * ( M_PI * 2 / self.subButtonCount)))]];
    }
    self.centerButton.center = CGPointMake(self.frame.size.width * 0.5f, self.frame.size.height * 0.5f);
}

- (void)configureCenterButton:(CGFloat)centerRadius image:(NSString *)imageName backgroundImage:(NSString *)backgroundImageName{
    
    self.centerButton = [[UIButton alloc]init];
    self.centerButton.layer.zPosition = 1;
    self.centerButton.bounds = CGRectMake(0, 0, centerRadius * 2, centerRadius * 2);
    [self.centerButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.centerButton setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    [self.centerButton addTarget:self action:@selector(centerButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.centerButton];
}

- (void)centerButtonPress {
    
    if (![self isExpanded]) {
        [self.subButtonsArrM enumerateObjectsUsingBlock:^(UIButton * but, NSUInteger idx, BOOL * stop) {
            [self button:self.subButtonsArrM[idx] appearAt:[self.appearLocationArrM[idx] CGPointValue] withDalay:0.5 duration:0.4];
        }]; self.expanded = YES;
    } else {
        NSInteger offset = -5;
        [self.subButtonsArrM enumerateObjectsUsingBlock:^(UIButton * but, NSUInteger idx, BOOL * stop) {
            [self button:self.subButtonsArrM[idx] shrinkAt:[self.appearLocationArrM[idx] CGPointValue] offsetAxisX:offset + arc4random()%10 offSetAxisY:offset + arc4random()%10 withDelay:arc4random()%5 / 10 + 0.5f animationDuration:1];
        }]; self.expanded = NO;
    }
}

- (void)configureSubButtons:(NSInteger)subButtonCount {
    
    self.subButtonsArrM = [NSMutableArray array];
    for (NSInteger i = 0; i < subButtonCount; i++) {
        self.subButton = [[UIButton alloc]init];
        self.subButton.center = self.birthLocation;
        self.subButton.bounds = CGRectMake(0, 0, self.subButtonRadius * 2, self.subButtonRadius * 2);
        [self.subButton addTarget:self action:@selector(subButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.subButton];
        [self.subButtonsArrM addObject:self.subButton];
    }
}

- (void)subButtonPress:(UIButton *)button {
    
    if (self.block) {
        self.block(self,button.tag);
    }
}

- (void)subButtonImage:(NSString *)imageName withTag:(NSInteger)tag {
    
    if (tag > self.subButtonCount) {
        tag = self.subButtonCount;
    }
    [self.subButtonsArrM[tag] setTag:tag];
    [self.subButtonsArrM[tag] setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)button:(UIButton *)button appearAt:(CGPoint)location withDalay:(CGFloat)delay duration:(CGFloat)duration {
    
    CAKeyframeAnimation * scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.duration = duration;
    scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]];
    scaleAnimation.calculationMode = kCAAnimationLinear;
    scaleAnimation.keyTimes = @[@(0.0f),@(delay),@(1.0f)];
    button.center = location;
    button.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    [button.layer addAnimation:scaleAnimation forKey:nil];
}

- (void)button:(UIButton *)button shrinkAt:(CGPoint)location offsetAxisX:(CGFloat)axisX offSetAxisY:(CGFloat)axisY withDelay:(CGFloat)delay animationDuration:(CGFloat)duration {
    
    CAKeyframeAnimation * rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.duration = duration * delay;
    rotation.values = @[@(0.0f),@(M_PI * 2),@(0.0)];
    rotation.keyTimes = @[@(0.0f),@(delay),@(1.0f)];
    
    CAKeyframeAnimation *shrink = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    shrink.duration = duration * (1 - delay);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, location.x, location.y);
    CGPathAddLineToPoint(path, NULL, location.x + axisX, location.y + axisY);
    CGPathAddLineToPoint(path, NULL, self.frame.size.width * 0.5f,self.frame.size.height * 0.5f);
    shrink.path = path;
    
    CGPathRelease(path);
    
    CAAnimationGroup *totalAnimation = [CAAnimationGroup animation];
    totalAnimation.duration = 1.0f;
    totalAnimation.animations = @[rotation,shrink];
    totalAnimation.fillMode = kCAFillModeForwards;
    totalAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    totalAnimation.delegate = self;
    
    button.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    button.center = self.birthLocation;
    [button.layer addAnimation:totalAnimation forKey:nil];
}

- (CGFloat)offsetAxisY:(CGFloat)axisX withAngel:(CGFloat)angel {
    return (axisX / tanf(((angel) * M_PI) / 180));
}

- (void)collapse {
    self.expanded = YES; [self centerButtonPress];
}

@end
