//
//  MainViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "MainViewController.h"

@interface EventView : UIView
@end
@implementation EventView

TouchBeganTest
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
    NSLog(@"%@ %s", [self class], __func__);
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
- (void)hitTestView:(HitTestView *)hitTestView matchView:(UIView *)view ;
@end

@interface HitTestView : UIView
@property (nonatomic, weak) id<HitTestViewDelegate> delegate;
@end

@interface HitTestView()
@property (nonatomic, weak) IBOutlet HitTestButton * button;
@end

@implementation HitTestView

TouchTest
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

@interface HitTestView_Gray3 : UIView @end
@implementation HitTestView_Gray3 TouchTest @end
@interface HitTestView_Gray2 : UIView @end
@implementation HitTestView_Gray2 TouchTest @end
@interface HitTestView_Gray1 : UIView @end
@implementation HitTestView_Gray1 TouchTest @end
@interface HitTestView_White2 : UIView @end
@implementation HitTestView_White2 TouchTest @end
@interface HitTestView_White1 : UIView @end
@implementation HitTestView_White1 TouchTest @end

@interface MainViewController () <HitTestViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet HitTestView *hitTestView;
@property (weak, nonatomic) IBOutlet UILabel *hitTestLabel;
@property (nonatomic, weak) UIButton * subButton;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"View";
    self.hitTestView.delegate = self;
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap:)];
    tapGesture.numberOfTapsRequired = 2;
    tapGesture.numberOfTouchesRequired = 1;
    tapGesture.delegate = self;
    [self.imageView addGestureRecognizer:tapGesture];
    UILongPressGestureRecognizer * longPressGestrue = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewLongPress:)];
    longPressGestrue.delegate = self;
    [self.imageView addGestureRecognizer:longPressGestrue];
    UISwipeGestureRecognizer  * swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewSwipe:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.imageView addGestureRecognizer:swipeGesture];
    UISwipeGestureRecognizer  * swipeGesture2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewSwipe:)];
    swipeGesture2.direction = UISwipeGestureRecognizerDirectionRight;
    [self.imageView addGestureRecognizer:swipeGesture2];
//    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewPan:)];
//    [self.imageView addGestureRecognizer:panGesture];
    UIRotationGestureRecognizer * rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewRoataion:)];
    [self.imageView addGestureRecognizer:rotationGesture];
    rotationGesture.delegate = self;
    UIPinchGestureRecognizer * pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewPinch:)];
    pinchGesture.delegate = self;
    [self.imageView addGestureRecognizer:pinchGesture];
}

- (void)imageViewTap:(UITapGestureRecognizer *)sender {
    Log
    [UIView animateWithDuration:.5 animations:^{
        self.imageView.transform = CGAffineTransformScale(self.imageView.transform, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void)imageViewLongPress:(UILongPressGestureRecognizer *)sender {
    Log
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"UIGestureRecognizerStateBegan");
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"UIGestureRecognizerStateChanged");
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"UIGestureRecognizerStateEnded");
            break;
        default:
            break;
    }
    [UIView animateWithDuration:.5 animations:^{
        self.imageView.transform = CGAffineTransformScale(self.imageView.transform, .9, .9);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void)imageViewSwipe:(UISwipeGestureRecognizer *)sender {
    Log
    if (sender.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"UISwipeGestureRecognizerDirectionDown");
    } else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"UISwipeGestureRecognizerDirectionRight");
    }
    [self transformButtonClick:nil];
}

- (void)imageViewPan:(UIPanGestureRecognizer *)sender {
    Log
    CGPoint translation = [sender translationInView:self.imageView];
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, translation.x, translation.y);
    [sender setTranslation:CGPointMake(0, 0) inView:self.imageView];
    [self gestureRecognizerStateEnded:sender];
}

- (void)imageViewRoataion:(UIRotationGestureRecognizer *)sender {
    Log
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, sender.rotation);
    sender.rotation = 0.;
    [self gestureRecognizerStateEnded:sender];
}

- (void)imageViewPinch:(UIPinchGestureRecognizer *)sender {
    Log
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, sender.scale, sender.scale);
    sender.scale = 1.;
    [self gestureRecognizerStateEnded:sender];
}

- (void)gestureRecognizerStateEnded:(UIGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:.5 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    CGPoint location = [touch locationInView:self.imageView];
//    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]] &&
//        location.x < self.imageView.bounds.size.width * .5 ) {
//        return YES;
//    } else if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] &&
//               location.x > self.imageView.bounds.size.width * .5) {
//        return YES;
//    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

TouchTest
- (void)hitTestView:(id)hitTestView matchView:(UIView *)view {
    NSLog(@"%@", [view class]);
    self.hitTestLabel.text = [NSString stringWithFormat:@"%@ - %p", NSStringFromClass([view class]), view];
}

- (IBAction)addButtonClick:(HitTestButton *)sender {
    if (!self.subButton) {
        UIButton * subButton = [UIButton new];
        [subButton setBackgroundImage:[UIImage imageNamed:@"Resize"] forState:UIControlStateNormal];
        [subButton setBackgroundImage:[UIImage imageNamed:@"Avatar"] forState:UIControlStateHighlighted];
        subButton.alpha = .7;
        subButton.frame = CGRectMake(-69, -19, 60, 60);
        sender.subButton = subButton;
        [sender addSubview:subButton];
        _subButton = subButton;
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
