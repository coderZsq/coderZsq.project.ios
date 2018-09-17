//
//  LayerController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "LayerController.h"

@interface LayerController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, weak) CALayer * layer;
@end

@implementation LayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Layer";
    
    CALayer * layer = [CALayer layer];
    _layer = layer;
    //    layer.frame = CGRectMake(0, 0, 100, 100);
    layer.anchorPoint = CGPointMake(.5, .5);
    layer.position = CGPointMake(50, 50);
    layer.bounds = CGRectMake(0, 0, 100, 100);
    [self.contentView.layer addSublayer:layer];
    layer.borderColor = [SystemColor colorWithAlphaComponent:.7].CGColor;
    layer.borderWidth = 3;
    layer.shadowOpacity = 1.;
    layer.shadowOffset = CGSizeMake(3, 3);
    layer.shadowColor = [UIColor lightGrayColor].CGColor;
    layer.cornerRadius = 50;
    layer.masksToBounds = YES;
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"Avatar"].CGImage);
#if 0
    //        self.layerView.layer.transform = CATransform3DMakeRotation(M_PI, 1, 1, 0);
    self.layerView.layer.transform = CATransform3DRotate(self.layerView.layer.transform, M_PI, 1, 1, 0);
    //        self.layerView.layer.transform = CATransform3DMakeTranslation(50, 50, 1);
    self.layerView.layer.transform = CATransform3DTranslate(self.layerView.layer.transform, 50, 50, 0);
    //        self.layerView.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1);
    self.layerView.layer.transform = CATransform3DScale(self.layerView.layer.transform, 1.2, 1.2, 1);
#endif
    //        NSValue * value = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 0)];
    //        [self.layerView.layer setValue:value forKey:@"transform"];
    [layer setValue:@(M_PI) forKeyPath:@"transform.rotation.x"];
    [layer setValue:@(1.) forKeyPath:@"transform.scale"];
    NSLog(@"%@", NSStringFromCGPoint(self.contentView.center));
    NSLog(@"%@", NSStringFromCGPoint(self.contentView.layer.position));
}

- (IBAction)transactionButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [CATransaction begin];
    CATransaction.disableActions = NO;
    CATransaction.animationDuration = .5;
    self.layer.cornerRadius = sender.selected ? 0 : 50;
    self.layer.transform = CATransform3DRotate(self.layer.transform, M_PI, 0, 0, 1);
    [CATransaction commit];
}


@end
