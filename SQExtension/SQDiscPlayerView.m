//
//  SQDiscPlayerView.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQDiscPlayerView.h"

static const CGFloat kRotationDuration = 8.0;

@interface SQDiscPlayerView ()

@property (nonatomic,strong) UIImageView      * albumImageView;
@property (nonatomic,strong) UIImageView      * playStateView;
@property (nonatomic,strong) CABasicAnimation * rotationAnimation;

@end

@implementation SQDiscPlayerView

- (void)drawRect:(CGRect)rect {
    
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    self.clipsToBounds = YES;
    self.userInteractionEnabled = YES;
    
    self.layer.cornerRadius = center.x;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 2;
    self.layer.shadowOpacity = 0.6;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    
    UIImage * albumImage = self.albumImage;
    self.albumImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.albumImageView setCenter:center];
    [self.albumImageView setImage:albumImage];
    [self addSubview:self.albumImageView];
    
    UIImage * stateImage;
    if (self.isPlay) {
        stateImage = [UIImage imageNamed:@"button2"];
    }else{
        stateImage = [UIImage imageNamed:@"button1"];
    }
    
    self.playStateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, stateImage.size.width, stateImage.size.height)];
    [self.playStateView setCenter:center];
    [self.playStateView setImage:stateImage];
    [self addSubview:self.playStateView];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(nil, self.frame.size.width, self.frame.size.height, 8.0, self.frame.size.width * 4, colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CFRelease(colorSpace);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextBeginPath(context);
    CGContextAddArc(context, center.x, center.y, center.x , 0, 2 * M_PI, 0);
    CGContextClosePath(context);
    CGContextSetLineWidth(context, 15.0);
    CGContextStrokePath(context);
    
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    UIImage * image2 = [UIImage imageWithCGImage:image];
    UIImageView * imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width , self.frame.size.height)];
    imageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    imageView.image = image2;
    [self addSubview:imageView];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    
    if (self.rotationDuration == 0) {
        self.rotationDuration = kRotationDuration;
    }
    rotationAnimation.duration = self.rotationDuration;
    rotationAnimation.repeatCount = INFINITY;
    rotationAnimation.cumulative = NO;
    [self.albumImageView.layer addAnimation:rotationAnimation forKey:nil];
    
    if (!self.isPlay) {
        self.layer.speed = 0.0;
    }
}

- (void)setIsPlay:(BOOL)aIsPlay {
    
    _isPlay = aIsPlay;
    
    if (self.isPlay) {
        [self startRotation];
    } else {
        [self pauseRotation];
    }
}

- (void)setAlbumImage:(UIImage *)albumImage {
    self.albumImageView.image = _albumImage = albumImage;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.isPlay = !self.isPlay;
}

- (void)startRotation {
    
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed      = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime  = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
    
    self.playStateView.image = [UIImage imageNamed:@"button2"];
    self.playStateView.alpha = 0;
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.playStateView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         if (finished){
                             [UIView animateWithDuration:1.0 animations:^{self.playStateView.alpha = 0;}];
                         }
                     }
     ];
}

- (void)pauseRotation{
    
    self.playStateView.image = [UIImage imageNamed:@"button1"];
    self.playStateView.alpha = 0;
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.playStateView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         if (finished){
                             [UIView animateWithDuration:1.0 animations:^{
                                 self.playStateView.alpha = 0;
                                 CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
                                 self.layer.speed = 0.0;
                                 self.layer.timeOffset = pausedTime;
                             }];
                         }
                     }
     ];
}

- (void)play {
    self.isPlay = YES;
}

- (void)pause {
    self.isPlay = NO;
}

@end
