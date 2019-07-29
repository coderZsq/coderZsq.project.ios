//
//  SQMagnetTitleView.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/14.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQMagnetTitleView.h"
#import "NSObject+SQExtension.h"

@interface SQMagnetTitleView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@end

@implementation SQMagnetTitleView

+ (instancetype)titleViewWithTitle:(NSString *)title image:(UIImage *)image rate:(NSString *)rate {
    SQMagnetTitleView *titleView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(SQMagnetTitleView.class) owner:nil options:nil].firstObject;
    titleView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 130);
    titleView.imageView.image = image;
    titleView.titleLabel.text = title;
    titleView.rateLabel.text = rate;
    return titleView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedown:)];
    gesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:gesture];
}

- (void)swipedown:(UISwipeGestureRecognizer *)gesture {
    if (gesture.direction == UISwipeGestureRecognizerDirectionDown) {
        [self close:nil];
    }
}

- (IBAction)close:(id)sender {
    [[self getCurrentViewController] dismissViewControllerAnimated:YES completion:nil];
}

@end
