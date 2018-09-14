//
//  MainViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "MainViewController.h"
#import <MBProgressHUD.h>

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
    [self touchesEnded:touches withEvent:event];
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

typedef NS_ENUM(NSInteger, SegmentedType) {
    SegmentedTypeAdjust = 0,
    SegmentedTypeSelect,
    SegmentedTypeErase
};

@interface MainViewController () <HitTestViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet HitTestView *hitTestView;
@property (weak, nonatomic) IBOutlet UILabel *hitTestLabel;
@property (nonatomic, weak) UIButton * subButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *screencaptureImageView;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, weak) UIView * maskView;
@property (nonatomic, assign) SegmentedType segmentedType;
@end

@implementation MainViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    Log
    self.topConstraint.constant = Top + 20;
}
- (void)viewWillLayoutSubviews {[super viewWillLayoutSubviews];Log}
- (void)viewDidAppear:(BOOL)animated {[super viewDidAppear:animated];Log}
- (void)viewWillAppear:(BOOL)animated {[super viewWillAppear:animated];Log}

- (void)viewDidLoad {
    [super viewDidLoad];
    Log
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
    [self resetOperation];
}

- (void)imageViewTap:(UITapGestureRecognizer *)sender {
    Log
    [UIView animateWithDuration:.5 animations:^{
        sender.view.transform = CGAffineTransformScale(self.imageView.transform, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 animations:^{
            sender.view.transform = CGAffineTransformIdentity;
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
        sender.view.transform = CGAffineTransformScale(self.imageView.transform, .9, .9);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 animations:^{
            sender.view.transform = CGAffineTransformIdentity;
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
    CGPoint translation = [sender translationInView:sender.view];
    sender.view.transform = CGAffineTransformTranslate(sender.view.transform, translation.x, translation.y);
    [sender setTranslation:CGPointMake(0, 0) inView:sender.view];
    [self gestureRecognizerStateEnded:sender];
}

- (void)imageViewRoataion:(UIRotationGestureRecognizer *)sender {
    Log
    sender.view.transform = CGAffineTransformRotate(sender.view.transform, sender.rotation);
    sender.rotation = 0.;
    [self gestureRecognizerStateEnded:sender];
}

- (void)imageViewPinch:(UIPinchGestureRecognizer *)sender {
    Log
    sender.view.transform = CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale);
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
        subButton.frame = CGRectMake(-79, -19, 60, 60);
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
    
    CGFloat value =  arc4random_uniform(256) / 255.;
    UIImage * image = [UIImage imageNamed:@"Avatar"];
    NSString * text = @"@Castie!";
    CGFloat borderWidth = 10.;
    CGSize size = CGSizeMake(image.size.width + 2 * borderWidth, image.size.height + 2 * borderWidth);
    UIGraphicsBeginImageContext(size);
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [[[UIColor lightGrayColor]colorWithAlphaComponent:.15]set];
    [path fill];
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:100] addClip];
    [image drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    [text drawAtPoint:CGPointMake(110, 10) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:50.], NSForegroundColorAttributeName : [UIColor colorWithRed:value green:value blue:value alpha:1.]}];
    UIImage * getimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.imageView.image = getimage;
}

- (IBAction)saveOperation {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Save To Album?" message:@"confirm it will be stay your album..." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //    UIGraphicsBeginImageContext(self.view.bounds.size);
        UIGraphicsBeginImageContextWithOptions(self.screencaptureImageView.bounds.size, NO, [UIScreen mainScreen].scale);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [self.screencaptureImageView.layer renderInContext:ctx];
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        //    NSData * data = UIImagePNGRepresentation(image);
        //    NSData * data = UIImageJPEGRepresentation(image, 1.);
        //    [data writeToFile:@"/Users/zhushuangquan/Desktop/image.jpg" atomically:YES];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        UIGraphicsEndImageContext();
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"%@", !error ? @"Save Success" : @"Save Failure");
    if (!error) {
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"Saved";
        hud.mode = MBProgressHUDModeText;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }
}

- (IBAction)resetOperation {
    //    self.screencaptureImageView.image = nil;
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:ctx];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.screencaptureImageView.image = image;
    [UIView animateWithDuration:.5 animations:^{
        self.screencaptureImageView.transform = CGAffineTransformIdentity;
    }];
}

- (UIView *)maskView {
    
    if (!_maskView) {
        UIView * maskView = [[UIView alloc]init];
        maskView.alpha = .5;
        maskView.backgroundColor = [UIColor blackColor];
        [self.screencaptureImageView addSubview:maskView];
        _maskView = maskView;
    }
    return _maskView;
}

- (IBAction)panGesture:(UIPanGestureRecognizer *)sender {
    
    switch (self.segmentedType) {
        case SegmentedTypeAdjust:
            [self imageViewPan:sender];
            break;
        case SegmentedTypeSelect: {
            CGPoint location = [sender locationInView:self.screencaptureImageView];
            if (sender.state == UIGestureRecognizerStateBegan) {
                self.startPoint = location;
            } else if (sender.state == UIGestureRecognizerStateChanged) {
                CGFloat X = self.startPoint.x;
                CGFloat Y = self.startPoint.y;
                CGFloat W = location.x - self.startPoint.x;
                CGFloat H = location.y - self.startPoint.y;
                self.maskView.frame = CGRectMake(X, Y, W, H);
            } else if (sender.state == UIGestureRecognizerStateEnded) {
                //        self.maskView.frame = CGRectZero;
                [self.maskView removeFromSuperview];
                //        UIGraphicsBeginImageContextWithOptions(self.screencaptureImageView.bounds.size, NO, .0);
                //        UIRectClip(self.maskView.frame);
                //        CGContextRef ctx = UIGraphicsGetCurrentContext();
                //        [self.screencaptureImageView.layer renderInContext:ctx];
                //        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
                //        UIGraphicsEndImageContext();
                //        self.screencaptureImageView.image = image;
                UIGraphicsBeginImageContext(self.screencaptureImageView.bounds.size);
                [self.screencaptureImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
                UIImage * parentImage=UIGraphicsGetImageFromCurrentImageContext();
                CGRect subImageRect= self.maskView.frame;
                CGImageRef subImageRef = CGImageCreateWithImageInRect(parentImage.CGImage, subImageRect);
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGContextDrawImage(context, subImageRect, subImageRef);
                UIImage * image = [UIImage imageWithCGImage:subImageRef];
                UIGraphicsEndImageContext();
                self.screencaptureImageView.image = image;
            }
            break;
        }
        case SegmentedTypeErase: {
            CGPoint location = [sender locationInView:self.screencaptureImageView];
            CGRect rect = CGRectMake(location.x - 15, location.y, 30, 30);
            UIGraphicsBeginImageContextWithOptions(self.screencaptureImageView.bounds.size, NO, .0);
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            [self.screencaptureImageView.layer renderInContext:ctx];
            CGContextClearRect(ctx, rect);
            UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
            self.screencaptureImageView.image = image;
            UIGraphicsEndImageContext();
            break;
        }
    }
}

- (IBAction)pinchGesture:(UIPinchGestureRecognizer *)sender {
    if (self.segmentedType != SegmentedTypeAdjust) return;
    [self imageViewPinch:sender];
}

- (IBAction)rotationGesture:(UIRotationGestureRecognizer *)sender {
    if (self.segmentedType != SegmentedTypeAdjust) return;
    [self imageViewRoataion:sender];
}

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    self.segmentedType = sender.selectedSegmentIndex;
    if (self.segmentedType != SegmentedTypeAdjust) {
        [UIView animateWithDuration:.5 animations:^{
            self.screencaptureImageView.transform = CGAffineTransformIdentity;
        }];
    }
}

TouchTest

@end
