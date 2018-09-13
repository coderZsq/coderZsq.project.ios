//
//  ViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ViewController.h"

@interface EventView : UIView
@end
@implementation EventView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint previousLocation = [touch previousLocationInView:self];
    CGPoint currentLocation = [touch locationInView:self];
    NSLog(@"%@", NSStringFromCGPoint(previousLocation));
    NSLog(@"%@", NSStringFromCGPoint(currentLocation));
    CGFloat offsetX = currentLocation.x - previousLocation.x;
    CGFloat offsetY = currentLocation.y - previousLocation.y;
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    [UIView animateWithDuration:.5 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
}

@end

@interface HitTestButton : UIButton
@property (nonatomic, weak) UIButton * subButton;
@end
@implementation HitTestButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.subButton && [self.subButton pointInside:[self convertPoint:point toView:self.subButton] withEvent:event]) {
        return self.subButton;
    } else return [super hitTest:point withEvent:event];
}

@end

@class HitTestView;
@protocol HitTestViewDelegate <NSObject>
- (void)hitTestView:(id)hitTestView matchView:(UIView *)view ;
@end

@interface HitTestView : UIView
@property (nonatomic, weak) id<HitTestViewDelegate> delegate;
@end

@interface HitTestView()
@property (nonatomic, weak) IBOutlet HitTestButton * button;
@end

@implementation HitTestView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", [self class]);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self.button hitTest:[self convertPoint:point toView:self.button] withEvent:event]) {
        if (self.button.subButton && [self.button.subButton pointInside:[self convertPoint:point toView:self.button.subButton] withEvent:event]) {
            [self hitTestView:self matchView:self.button.subButton];
            return self.button.subButton;
        } else {
            [self hitTestView:self matchView:self.button];
            return self.button;
        }
    }
    UIView * view = [super hitTest:point withEvent:event];
    [self hitTestView:self matchView:view];
    return view;
}

- (void)hitTestView:(id)hitTestView matchView:(UIView *)view  {
    if ([self.delegate respondsToSelector:@selector(hitTestView:matchView:)]) {
        [self.delegate hitTestView:self matchView:view];
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL pointInside = [super pointInside:point withEvent:event];
    NSLog(@"PointInside - %@", pointInside ? @"YES" : @"NO");
    return pointInside;
}

@end

#define TouchBeganTest - (void)touchesBegan:(NSSet<UITouch *> *)touches\
withEvent:(UIEvent *)event {NSLog(@"%@", [self class]);}

@interface HitTestView_Gray3 : UIView @end
@implementation HitTestView_Gray3 TouchBeganTest @end
@interface HitTestView_Gray2 : UIView @end
@implementation HitTestView_Gray2 TouchBeganTest @end
@interface HitTestView_Gray1 : UIView @end
@implementation HitTestView_Gray1 TouchBeganTest @end
@interface HitTestView_White2 : UIView @end
@implementation HitTestView_White2 TouchBeganTest @end
@interface HitTestView_White1 : UIView @end
@implementation HitTestView_White1 TouchBeganTest @end

@interface ViewController () <HitTestViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet HitTestView *hitTestView;
@property (weak, nonatomic) IBOutlet UILabel *hitTestLabel;
@property (nonatomic, strong) UIButton * subButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"View";
    self.hitTestView.delegate = self;
}

- (void)hitTestView:(id)hitTestView matchView:(UIView *)view {
    NSLog(@"%@", [view class]);
    self.hitTestLabel.text = [NSString stringWithFormat:@"%@ - %p", NSStringFromClass([view class]), view];
}

- (IBAction)addButtonClick:(HitTestButton *)sender {
    if (!self.subButton) {
        self.subButton = [UIButton new];
        [self.subButton setBackgroundImage:[UIImage imageNamed:@"Resize"] forState:UIControlStateNormal];
        [self.subButton setBackgroundImage:[UIImage imageNamed:@"Avatar"] forState:UIControlStateHighlighted];
        self.subButton.alpha = .7;
        self.subButton.frame = CGRectMake(-69, -19, 60, 60);
        sender.subButton = self.subButton;
        [sender addSubview:self.subButton];
    }
}

- (IBAction)transformButtonClick:(UIButton *)sender {
    [UIView animateWithDuration:.5 animations:^{
        sender.enabled = NO;
//        self.imageView.transform = CGAffineTransformMakeTranslation(0, 140);
        self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, 0, 110);
//        self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI);
//        self.imageView.transform = CGAffineTransformMakeScale(.8, .8);
        self.imageView.transform = CGAffineTransformScale(self.imageView.transform, .5, .5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            sender.enabled = YES;
        }];
    }];
}

@end



