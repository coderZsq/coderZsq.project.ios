//
//  PanViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "PanViewController.h"
#import <Masonry.h>
#import "SQSaveTool.h"

@interface PanViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIView * mainView;
@property (nonatomic, weak) UIView * secondaryView;
@property (nonatomic, assign, getter=isPan) BOOL pan;
@end

@implementation PanViewController

- (void)mainViewPan:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.mainView];
    [self positionWithOffset:translation.x];
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.mainView.frame.origin.x > [UIScreen mainScreen].bounds.size.width * .5) {
            CGFloat offset = [UIScreen mainScreen].bounds.size.width * (self.ratio ?self.ratio :.8) - self.mainView.frame.origin.x;
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
    self.pan = YES;
    [UIView animateWithDuration:.25 animations:^{
        [self positionWithOffset:[UIScreen mainScreen].bounds.size.width * (self.ratio ?self.ratio :.8)];
        CGRect frame = self.mainView.frame;
        frame.origin.x = [UIScreen mainScreen].bounds.size.width * (self.ratio ?self.ratio :.8);
        self.mainView.frame = frame;
    }];
}

- (void)unPan {
    self.pan = NO;
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
    if (self.mainView.frame.origin.x >= [UIScreen mainScreen].bounds.size.width * (self.ratio ?self.ratio :.8)) {
        CGRect frame = self.mainView.frame;
        frame.origin.x = [UIScreen mainScreen].bounds.size.width * (self.ratio ? self.ratio :.8);
        self.mainView.frame = frame;
    }
    CGFloat scale = 1 - (self.mainView.frame.origin.x * .3 / [UIScreen mainScreen].bounds.size.width);
    NSLog(@"%f", scale);
    self.mainView.transform = CGAffineTransformMakeScale(scale, scale);
}

- (void)setMainViewController:(UIViewController *)mainViewController {
    if (!_mainView) {
        _mainView = mainViewController.view;
        _mainView.backgroundColor = BackgroundColor;
        [self.view addSubview:_mainView];
        [_mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(mainViewPan:)];
        panGesture.delegate = self;
        [_mainView addGestureRecognizer:panGesture];
//        UIView * tapView = [UIView new];
//        [_mainView addSubview:tapView];
//        [tapView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.bottom.equalTo(self.mainView);
//            make.top.mas_equalTo(Top + 44);
//            make.width.mas_equalTo(self.mainView.bounds.size.width * .24);
//        }];
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(unPan)];
        tapGesture.delegate = self;
        [_mainView addGestureRecognizer:tapGesture];
        _mainView.layer.cornerRadius = 40;
        self.title = mainViewController.title;
        [self addChildViewController:mainViewController];
    }
}

- (void)setSecondaryViewController:(UIViewController *)secondaryViewController {
    if (!_secondaryView) {
        _secondaryView = secondaryViewController.view;
        [self.view insertSubview:_secondaryView atIndex:0];
        [_secondaryView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        [self addChildViewController:secondaryViewController];
    }
}

- (void)setFeatureViewController:(UIViewController *)featureViewController {
    
    NSString * version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString * preVersion = [SQSaveTool objectForKey:@"kVersion"];
    if ([version isEqualToString:preVersion]) return;
    
    _featureViewController = featureViewController;
    [self.view insertSubview:featureViewController.view aboveSubview:_mainView];
    [featureViewController.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self addChildViewController:featureViewController];
    [SQSaveTool setObject:version forKey:@"kVersion"];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.mainView.transform = CGAffineTransformIdentity;
}

TouchTest
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"%@", [touch.view class]);
    if (self.isPan) {
        return YES;
    } else if ([NSStringFromClass([touch.view class]) hasPrefix:@"HitTestView"]) {
        return NO;
    } else if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] && ![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return NO;
    }
    return YES;
}

@end
