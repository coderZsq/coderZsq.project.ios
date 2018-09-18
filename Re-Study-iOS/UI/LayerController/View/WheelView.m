//
//  WheelView.m
//  UI
//
//  Created by 朱双泉 on 2018/9/18.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "WheelView.h"
#import "Proxy.h"

@interface WheelButton : UIButton
@end

@implementation WheelButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * .5);
    if (CGRectContainsPoint(rect, point)) {
        return [super hitTest:point withEvent:event];
    } else {
        return nil;
    }
}

- (void)setHighlighted:(BOOL)highlighted {}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat W = 15;
    CGFloat H = 20;
    CGFloat X = (contentRect.size.width - W) * .5;
    CGFloat Y = 5;
    return CGRectMake(X, Y, W, H);
}

@end

@interface WheelView () <CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) UIButton * preSelectedButton;
@property (nonatomic, weak) CADisplayLink * link;
@end

@implementation WheelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    }
    return self;
}

+ (instancetype)wheelView {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSubviews];
}

- (void)setupSubviews {
    UIImage * image = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage * selectedImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat W = image.size.width / 12. * scale;
    CGFloat H = image.size.height * scale;
    CGFloat angle = 0.;
    for (NSInteger i = 0; i < 12; i++) {
        WheelButton * button = [WheelButton new];
        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        X = i * W;
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(X, Y, W, H));
        [button setImage:[UIImage imageWithCGImage:imageRef] forState:UIControlStateNormal];
        CGImageRef selectedImageRef = CGImageCreateWithImageInRect(selectedImage.CGImage, CGRectMake(X, Y, W, H));
        [button setImage:[UIImage imageWithCGImage:selectedImageRef] forState:UIControlStateSelected];
        button.bounds = CGRectMake(0, 0, 20, 50);
        button.layer.anchorPoint = CGPointMake(.5, 1);
        button.transform = CGAffineTransformMakeRotation(angle * M_PI / 180.);
        angle += 30.;
        [self.imageView addSubview:button];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [self buttonClick:button];
        }
    }
}

- (void)buttonClick:(UIButton *)sender {
    self.preSelectedButton.selected = NO;
    sender.selected = YES;
    self.preSelectedButton = sender;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (WheelButton * button in self.imageView.subviews) {
        button.layer.position = CGPointMake(self.imageView.bounds.size.width * .5, self.imageView.bounds.size.height * .5);
    }
}

- (CADisplayLink *)link {
    
    if (!_link) {
        CADisplayLink * link = [CADisplayLink displayLinkWithTarget:[Proxy proxyWithTarget:self] selector:@selector(update)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _link = link;
    }
    return _link;
}

- (void)update {
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI / 100.);
}

- (void)start {
    self.link.paused = NO;
}

- (void)pause {
    self.link.paused = YES;
}

- (IBAction)chosenButtonClick:(UIButton *)sender {
    CGAffineTransform transform = self.preSelectedButton.transform;
    CGFloat angle = atan2(transform.b, transform.a);
    [self pause];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self start];
    });
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.toValue = @(M_PI * 6 - angle);
    animation.repeatCount = 1;
    animation.duration = 1.;
    animation.delegate = self;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.imageView.layer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CGAffineTransform transform = self.preSelectedButton.transform;
    CGFloat angle = atan2(transform.b, transform.a);
    self.imageView.transform = CGAffineTransformMakeRotation(-angle);
    [self.imageView.layer removeAllAnimations];
}

@end
