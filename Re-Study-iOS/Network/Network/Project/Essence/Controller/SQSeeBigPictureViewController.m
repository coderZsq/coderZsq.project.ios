//
//  SQSeeBigPictureViewController.m
//  Network
//
//  Created by 朱双泉 on 2018/10/22.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSeeBigPictureViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SQSeeBigPictureViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView * imageView;
@end

@implementation SQSeeBigPictureViewController

- (IBAction)dismissButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonClick:(UIButton *)sender {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * imageView = [UIImageView new];
    _imageView = imageView;
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.image0]];
    [_scrollView addSubview:imageView];
    CGFloat h = [UIScreen mainScreen].bounds.size.width / _width * _height;
    imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, h);
    if (_is_bigPicture) {
        _scrollView.contentSize = CGSizeMake(0, h);
        _scrollView.delegate = self;
        if (_height > h) {
            _scrollView.maximumZoomScale = _height / h;
        }
    } else {
        imageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width * .5, [UIScreen mainScreen].bounds.size.width * .5);
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

@end
