//
//  PanViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "PanViewController.h"
#import <Masonry.h>

@interface PanViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIView * mainView;
@property (nonatomic, weak) UIView * leftView;
@end

@implementation PanViewController

- (void)mainViewPan:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.mainView];
    [self positionWithOffset:translation.x];
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.mainView.frame.origin.x > [UIScreen mainScreen].bounds.size.width * .5) {
            CGFloat offset = [UIScreen mainScreen].bounds.size.width * .8 - self.mainView.frame.origin.x;
            [UIView animateWithDuration:.25 animations:^{
                [self positionWithOffset:offset];
            }];
        } else {
            [self unPan];
        }
    }
    [sender setTranslation:CGPointZero inView:self.mainView];
}

- (void)pan {
    [UIView animateWithDuration:.25 animations:^{
        [self positionWithOffset:[UIScreen mainScreen].bounds.size.width * .8];
        CGRect frame = self.mainView.frame;
        frame.origin.x = [UIScreen mainScreen].bounds.size.width * .8;
        self.mainView.frame = frame;
    }];
}

- (void)unPan {
    [UIView animateWithDuration:.25 animations:^{
        self.mainView.transform = CGAffineTransformIdentity;
        self.mainView.frame = self.view.bounds;
    }];
}

- (void)positionWithOffset:(CGFloat)offset {
    CGRect frame = self.mainView.frame;
    frame.origin.x += offset;
    self.mainView.frame = frame;
    if (self.mainView.frame.origin.x <= 0) {
        self.mainView.frame = self.view.bounds;
    }
    if (self.mainView.frame.origin.x >= [UIScreen mainScreen].bounds.size.width * .8) {
        CGRect frame = self.mainView.frame;
        frame.origin.x = [UIScreen mainScreen].bounds.size.width * .8;
        self.mainView.frame = frame;
    }
    CGFloat scale = 1 - (self.mainView.frame.origin.x * .3 / [UIScreen mainScreen].bounds.size.width);
    NSLog(@"%f", scale);
    self.mainView.transform = CGAffineTransformMakeScale(scale, scale);
}

- (void)setMainViewController:(UIViewController *)mainViewController {
    if (!_mainView) {
        _mainView = mainViewController.view;
        [self.view addSubview:_mainView];
        [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(mainViewPan:)];
        panGesture.delegate = self;
        [_mainView addGestureRecognizer:panGesture];
        self.title = mainViewController.title;
        [self addChildViewController:mainViewController];
    }
}

- (void)setLeftViewController:(UIViewController *)leftViewController {
    if (!_leftView) {
        _leftView = leftViewController.view;
        [self.view insertSubview:_leftView atIndex:0];
        [_leftView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(unPan)];
        [_leftView addGestureRecognizer:tapGesture];
        [self addChildViewController:leftViewController];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.mainView.transform = CGAffineTransformIdentity;
}

TouchTest
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.mainView == touch.view ? YES : NO;
}
@end
