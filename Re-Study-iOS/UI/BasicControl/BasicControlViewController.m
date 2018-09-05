//
//  BasicControlViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "BasicControlViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface BasicControlViewController ()
@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, weak) UIView * contentView;
@property (nonatomic, weak) UIButton * addButton;
@property (nonatomic, weak) UIButton * minusButton;
@property (nonatomic, copy) NSArray * dataSource;
@end

@interface Model : NSObject
@property (nonatomic, copy) NSString * text;
@property (nonatomic, copy) NSString * backgroundColor;
@end

@implementation Model
@end

@implementation BasicControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * label = [UILabel new];
    label.text = @
    "https://github.com/coderZsq "
    "https://github.com/coderZsq "
    "https://github.com/coderZsq "
    "https://github.com/coderZsq "
    "https://github.com/coderZsq "
    "https://github.com/coderZsq "
    "https://github.com/coderZsq "
    "https://github.com/coderZsq "
    "https://github.com/coderZsq ";
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
    imageView.image = [UIImage imageNamed:@"Avatar"];
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
    
    NSMutableArray * animationImages = [NSMutableArray array];
    NSInteger count = 300;
    for (NSInteger i = 1; i <= count; i++) {
        NSString * imageName = [NSString stringWithFormat:@"Layer %li", i];
        NSString * imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
        UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
        [animationImages addObject:image];
    }
    UIImageView * frameImageView = [UIImageView new];
    frameImageView.frame = CGRectMake(90, 320, 200, 100);
    frameImageView.animationImages = animationImages;
    frameImageView.animationRepeatCount = 0;
    frameImageView.animationDuration = count * .03;
    [frameImageView startAnimating];
    [self.view addSubview:frameImageView];
    
    [self performSelector:@selector(selector) withObject:nil afterDelay:frameImageView.animationDuration];
    
    NSBundle * bundle = [NSBundle mainBundle];
    NSURL * url = [bundle URLForResource:@"video" withExtension:@"m4a"];
    self.player = [AVPlayer playerWithURL:url];
    [self.player play];
    
    UIButton * button = [UIButton new];
    button.backgroundColor = [UIColor lightGrayColor];
    button.frame = CGRectMake(90, 430, 200, 60);
    button.enabled = YES;
    [button setTitle:@"Avatar" forState:UIControlStateNormal];
    [button setTitle:@"Avatar Highlighted" forState:UIControlStateHighlighted];
//    [button setImage:[UIImage imageNamed:@"Avatar"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"Avatar"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(selector) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIView * view = [UIView new];
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    addButton.frame = CGRectMake(10, 6, 44, 44);
    [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIButton * minusButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    minusButton.frame = CGRectMake(74, 6, 44, 44);
    minusButton.enabled = NO;
    [minusButton addTarget:self action:@selector(minusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addButton];
    [view addSubview:minusButton];
    view.backgroundColor = [UIColor lightGrayColor];
    view.frame = CGRectMake(90, 500, 200, 190);
    view.clipsToBounds = YES;
    [self.view addSubview:view];
    
    _contentView = view;
    _addButton = addButton;
    _minusButton = minusButton;
}

- (void)selector {
    NSLog(@"%s", __func__);
}

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        NSMutableArray * dataSource  = [NSMutableArray array];
        NSString * path = [[NSBundle mainBundle] pathForResource:@"dataSource" ofType:@"plist"];
        NSArray * plist = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary * dict in plist) {
            Model * model = [Model new];
            model.text = dict[@"text"];
            model.backgroundColor = dict[@"backgroundColor"];
            [dataSource addObject:model];
        }
        _dataSource = dataSource;
    }
    return _dataSource;
}

- (void)addButtonClick:(UIButton *)sender {
   
    CGFloat width = 50;
    CGFloat height = 50;
    
    NSUInteger maxCol = 3;
    NSUInteger index = self.contentView.subviews.count;
    
    NSUInteger col = index % maxCol;
    CGFloat xSpace = (self.contentView.frame.size.width - maxCol * width) / (maxCol - 1);
    CGFloat x = col * (width + xSpace);
    
    NSUInteger row = index / maxCol;
    CGFloat ySpace = 20;
    CGFloat y = row * (height + ySpace);
    
    Model * model = self.dataSource[index - 2];
    UILabel * label = [UILabel new];
    label.frame = CGRectMake(x, y, width, height);
    label.text = model.text;
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByClipping;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    label.backgroundColor = [[UIColor class] performSelector:NSSelectorFromString(model.backgroundColor)];
#pragma clang diagnostic pop
    [self.contentView addSubview:label];
    
    self.minusButton.enabled = YES;
    if (self.contentView.subviews.count >= 9) {
        self.addButton.enabled = NO;
    }
}

- (void)minusButtonClick:(UIButton *)sender {
    [self.contentView.subviews.lastObject removeFromSuperview];
    
    self.addButton.enabled = YES;
    if (self.contentView.subviews.count == 2) {
        self.minusButton.enabled = NO;
    }
}

@end
