//
//  BasicControlController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "BasicControlController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+Resizing.h"

@interface __Model : NSObject
@property (nonatomic, copy) NSString * text;
@property (nonatomic, copy) NSString * backgroundColor;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end

@implementation __Model

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    return [[self alloc]initWithDict:dict];
}

@end

IB_DESIGNABLE
@interface __View : UIView
@property (nonatomic, copy) IBInspectable NSString * text;
@property (nonatomic, strong) IBInspectable UIColor * backgroundColor;
@property (nonatomic, strong) __Model * model;
- (void)setText:(NSString *)text backgroundColor:(UIColor *)backgroundColor;
- (instancetype)initWithModel:(__Model *)model;
+ (instancetype)viewWithModel:(__Model *)model;
+ (instancetype)view;
@end

@interface __View()
@property (nonatomic, weak) IBOutlet UILabel * label;
@end

@implementation __View

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel * label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByClipping;
        [self addSubview:label];
        _label = label;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"%s", __func__);
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"%s", __func__);
}

- (instancetype)initWithModel:(__Model *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

+ (instancetype)viewWithModel:(__Model *)model {
    if ([self view]) {
        __View * view = [self view];
        view.model = model;
        return view;
    }
    return [[self alloc]initWithModel:model];
}

+ (instancetype)view {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil
                                       options:nil]firstObject];
}

- (void)setText:(NSString *)text {
    _label.text = text;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _label.backgroundColor = backgroundColor;
}

- (void)setText:(NSString *)text backgroundColor:(UIColor *)backgroundColor {
    _label.text = text;
    _label.backgroundColor = backgroundColor;
}

- (void)setModel:(__Model *)model {
    _model = model;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self setText:model.text backgroundColor:[[UIColor class] performSelector:NSSelectorFromString(model.backgroundColor)]];
#pragma clang diagnostic pop
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = self.bounds;
}

@end

@interface __Button : UIButton
@end

@implementation __Button

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    }
    return self;
}
# if 0
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(contentRect.size.width - contentRect.size.height, 0, contentRect.size.height, contentRect.size.height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, contentRect.size.width - contentRect.size.height, contentRect.size.height);
}
#endif
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(self.frame.size.width - self.frame.size.height, 0, self.frame.size.height, self.frame.size.height);
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height);
}

@end

@interface BasicControlController ()
@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, weak) UIView * contentView;
@property (nonatomic, weak) UIButton * addButton;
@property (nonatomic, weak) UIButton * minusButton;
@property (nonatomic, weak) UILabel * hudLabel;
@property (nonatomic, copy) NSArray * dataSource;
@end

@implementation BasicControlController

- (void)dealloc {
    [_addButton removeObserver:self forKeyPath:@"enabled"];
    [_minusButton removeObserver:self forKeyPath:@"enabled"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Basic Control";
    self.view.backgroundColor = BackgroundColor;
    
    UIScrollView * scrollView = [UIScrollView new];
    scrollView.frame = self.view.bounds;
    scrollView.contentInset = UIEdgeInsetsMake(-Top, 0, 0, 0);
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 730);
    [self.view addSubview:scrollView];
    
    UILabel * label = [UILabel new];
    label.text = @
    "github.com/coderZsq "
    "github.com/coderZsq "
    "github.com/coderZsq "
    "github.com/coderZsq "
    "github.com/coderZsq "
    "github.com/coderZsq "
    "github.com/coderZsq "
    "github.com/coderZsq "
    "github.com/coderZsq "
    "github.com/coderZsq ";
    label.backgroundColor = [UIColor lightGrayColor];
    label.frame = CGRectMake(90, 100, 200, 100);
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [scrollView addSubview:label];
    
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
    
    UIImageView * imageView = [UIImageView new];
    imageView.backgroundColor = [UIColor lightGrayColor];
    imageView.frame = CGRectMake(90, 210, 200, 100);
    imageView.image = [UIImage imageNamed:@"Avatar"];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.clipsToBounds = YES;
    UIToolbar * toolbar = [UIToolbar new];
    toolbar.frame = imageView.bounds;
    toolbar.barStyle = UIBarStyleDefault;
    toolbar.alpha = .5;
    [imageView addSubview:toolbar];
    [scrollView addSubview:imageView];
    
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
        NSString * imageName = [NSString stringWithFormat:@"Layer %li", (long)i];
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
    [scrollView addSubview:frameImageView];
    
    [self performSelector:@selector(selector) withObject:nil afterDelay:frameImageView.animationDuration];
    
    NSBundle * bundle = [NSBundle mainBundle];
    NSURL * url = [bundle URLForResource:@"video" withExtension:@"m4a"];
    self.player = [AVPlayer playerWithURL:url];
//    [self.player play];
    
    __Button * button = [__Button new];
    button.backgroundColor = [UIColor lightGrayColor];
    button.frame = CGRectMake(90, 430, 200, 60);
    [button setTitle:@"Avatar" forState:UIControlStateNormal];
    [button setTitle:@"Avatar Highlighted" forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"Avatar"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizingImageWithName:@"Resize"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(selector) forControlEvents:UIControlEventTouchUpInside];
    button.enabled = YES;
    button.adjustsImageWhenHighlighted = NO;
//    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [scrollView addSubview:button];
    
    UIView * view = [UIView new];
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    addButton.frame = CGRectMake(10, 6, 44, 44);
    [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [addButton addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew |  NSKeyValueObservingOptionOld context:@"addButton"];
    UIButton * minusButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    minusButton.frame = CGRectMake(74, 6, 44, 44);
    minusButton.enabled = NO;
    [minusButton addTarget:self action:@selector(minusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [minusButton addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew |  NSKeyValueObservingOptionOld context:@"minusButton"];
    [view addSubview:addButton];
    [view addSubview:minusButton];
    view.backgroundColor = [UIColor lightGrayColor];
    view.frame = CGRectMake(90, 500, 200, 190);
    view.clipsToBounds = YES;
    [scrollView addSubview:view];
    
    UILabel * hudLabel = [UILabel new];
    hudLabel.frame = CGRectMake(140, 580, 100, 30);
    hudLabel.backgroundColor = [UIColor blackColor];
    hudLabel.textColor = [UIColor whiteColor];
    hudLabel.textAlignment = NSTextAlignmentCenter;
    hudLabel.alpha = .0;
    hudLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    [scrollView addSubview:hudLabel];

    _contentView = view;
    _addButton = addButton;
    _minusButton = minusButton;
    _hudLabel = hudLabel;
}

- (void)selector {
    NSLog(@"%s", __func__);
}

- (NSArray *)dataSource {
    
    if (!_dataSource) {
        NSMutableArray * dataSource  = [NSMutableArray array];
        NSString * path = [[NSBundle mainBundle] pathForResource:@"basiccontrol" ofType:@"plist"];
        NSArray * plist = [NSArray arrayWithContentsOfFile:path];
        NSLog(@"%s - %@", __func__, [plist valueForKeyPath:@"text"]);
        NSLog(@"%s - %@", __func__, [plist valueForKeyPath:@"@count"]);
//        NSLog(@"%s - %@", __func__, [plist valueForKeyPath:@"@max.xxx"]);
//        NSLog(@"%s - %@", __func__, [plist valueForKeyPath:@"@min.xxx"]);
//        NSLog(@"%s - %@", __func__, [plist valueForKeyPath:@"@avg.xxx"]);
        for (NSDictionary * dict in plist) {
            [dataSource addObject:[__Model modelWithDict:dict]];
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
    
    __View * view = [__View viewWithModel:self.dataSource[index - 2]];
    view.frame = CGRectMake(x, y, width, height);
    [self.contentView addSubview:view];
    
    self.minusButton.enabled = YES;
    if (self.contentView.subviews.count >= self.dataSource.count + 2) {
        self.addButton.enabled = NO;
    }
    
    if (!self.addButton.enabled) {
        [self showHUD:@"can't add!!"];
    }
}

- (void)minusButtonClick:(UIButton *)sender {
    [self.contentView.subviews.lastObject removeFromSuperview];
    
    self.addButton.enabled = YES;
    if (self.contentView.subviews.count == 2) {
        self.minusButton.enabled = NO;
    }
    
    if (!self.minusButton.enabled) {
        [self showHUD:@"can't minus!!"];
    }
}

- (void)showHUD:(NSString *)text {
    self.hudLabel.text = text;
    [UIView animateWithDuration:1. animations:^{
        self.hudLabel.alpha = 1.;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1. delay:1.5 options:kNilOptions animations:^{
            self.hudLabel.alpha = .0;
        } completion:nil];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@ - %@ - %@ - %@ - %@", keyPath, object, change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey], context);
}

@end
