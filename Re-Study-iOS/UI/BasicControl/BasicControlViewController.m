//
//  BasicControlViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "BasicControlViewController.h"

@interface BasicControlViewController ()

@end

@implementation BasicControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * label = [UILabel new];
    label.text = @"https://github.com/coderZsq https://github.com/coderZsq https://github.com/coderZsq"
                  "https://github.com/coderZsq https://github.com/coderZsq https://github.com/coderZsq"
                  "https://github.com/coderZsq https://github.com/coderZsq https://github.com/coderZsq";
    label.backgroundColor = [UIColor lightGrayColor];
    label.frame = CGRectMake(90, 100, 200, 100);
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self.view addSubview:label];
    
#if 0
    typedef NS_ENUM(NSInteger, NSLineBreakMode) {
        NSLineBreakByWordWrapping = 0,         // Wrap at word boundaries, default
        NSLineBreakByCharWrapping,        // Wrap at character boundaries
        NSLineBreakByClipping,        // Simply clip
        NSLineBreakByTruncatingHead,    // Truncate at head of line: "...wxyz"
        NSLineBreakByTruncatingTail,    // Truncate at tail of line: "abcd..."
        NSLineBreakByTruncatingMiddle    // Truncate middle of line:  "ab...yz"
    } NS_ENUM_AVAILABLE(10_0, 6_0);
#endif
    
//    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"avatar"]];
    
//    UIImageView * imageView = [[UIImageView alloc]init];
//    imageView.image = [UIImage imageNamed:@"avatar"];
//    CGRect tempFrame = imageView.frame;
//    tempFrame.size = imageView.image.size;
//    imageView.frame = tempFrame;
    
    UIImageView * imageView = [UIImageView new];
    imageView.backgroundColor = [UIColor lightGrayColor];
    imageView.frame = CGRectMake(90, 210, 200, 100);
    imageView.image = [UIImage imageNamed:@"avatar"];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.clipsToBounds = YES;
    [self.view addSubview:imageView];
 
#if 0
    typedef NS_ENUM(NSInteger, UIViewContentMode) {
        UIViewContentModeScaleToFill,
        UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
        UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
        UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
        UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
        UIViewContentModeTop,
        UIViewContentModeBottom,
        UIViewContentModeLeft,
        UIViewContentModeRight,
        UIViewContentModeTopLeft,
        UIViewContentModeTopRight,
        UIViewContentModeBottomLeft,
        UIViewContentModeBottomRight,
    };
#endif
}

@end
