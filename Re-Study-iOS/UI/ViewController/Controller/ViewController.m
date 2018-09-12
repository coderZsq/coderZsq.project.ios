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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"View";
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
