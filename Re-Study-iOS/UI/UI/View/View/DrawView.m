//
//  DrawView.m
//  UI
//
//  Created by 朱双泉 on 2018/9/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "DrawView.h"
#import "Proxy.h"

@interface HandleView () <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIImageView * imageView;
@end

@implementation HandleView

- (UIImageView *)imageView {
    
    if (!_imageView) {
        UIImageView * imageView = [UIImageView new];
        imageView.frame = self.bounds;
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageView];
        _imageView = imageView;
        self.clipsToBounds = YES;
        [self addGestureRecognizers];
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

- (void)addGestureRecognizers {
    UILongPressGestureRecognizer * longPressGestrue = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewLongPress:)];
    longPressGestrue.delegate = self;
    [self.imageView addGestureRecognizer:longPressGestrue];
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewPan:)];
    [self.imageView addGestureRecognizer:panGesture];
    UIRotationGestureRecognizer * rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewRoataion:)];
    [self.imageView addGestureRecognizer:rotationGesture];
    rotationGesture.delegate = self;
    UIPinchGestureRecognizer * pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewPinch:)];
    pinchGesture.delegate = self;
    [self.imageView addGestureRecognizer:pinchGesture];
}

- (void)imageViewLongPress:(UILongPressGestureRecognizer *)sender {
    Log
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            [UIView animateWithDuration:.25 animations:^{
                self.imageView.alpha = .0;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:.25 animations:^{
                    self.imageView.alpha = 1.;
                } completion:^(BOOL finished) {
                    UIGraphicsBeginImageContext(self.bounds.size);
                    CGContextRef ctx = UIGraphicsGetCurrentContext();
                    [self.layer renderInContext:ctx];
                    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
                    if ([self.delegate respondsToSelector:@selector(handleView:image:)]) {
                        [self.delegate handleView:self image:image];
                    }
                    [self removeFromSuperview];
                    UIGraphicsEndImageContext();
                }];
            }];
        }   break;
        default:
            break;
    }
}

- (void)imageViewPan:(UIPanGestureRecognizer *)sender {
    Log
    CGPoint translation = [sender translationInView:sender.view];
    sender.view.transform = CGAffineTransformTranslate(sender.view.transform, translation.x, translation.y);
    [sender setTranslation:CGPointMake(0, 0) inView:sender.view];
}

- (void)imageViewRoataion:(UIRotationGestureRecognizer *)sender {
    Log
    sender.view.transform = CGAffineTransformRotate(sender.view.transform, sender.rotation);
    sender.rotation = 0.;
}

- (void)imageViewPinch:(UIPinchGestureRecognizer *)sender {
    Log
    sender.view.transform = CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale);
    sender.scale = 1.;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end

@interface BezierPath: UIBezierPath
@property (nonatomic, strong) UIColor * lineColor;
@end
@implementation BezierPath
@end

@interface DrawView5 ()
@property (nonatomic, strong) BezierPath * path;
@property (nonatomic, strong) NSMutableArray * pathArrayM;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor * lineColor;
@end

@implementation DrawView5

- (void)handleView:(HandleView *)handleView image:(UIImage *)image {
    self.image = image;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    [self.pathArrayM addObject:image];
    [self setNeedsDisplay];
}

- (void)clear {
    [self.pathArrayM removeAllObjects];
    [self setNeedsDisplay];
}

- (void)undo {
    [self.pathArrayM removeLastObject];
    [self setNeedsDisplay];
}

- (void)eraser {
    _lineColor = self.backgroundColor;
}

- (void)setLineWidth:(CGFloat)width {
    _lineWidth = width;
}

- (void)setLineColor:(UIColor *)color {
    _lineColor = [color colorWithAlphaComponent:.7];
}

- (NSMutableArray *)pathArrayM {
    
    if (!_pathArrayM) {
        _pathArrayM = @[].mutableCopy;
    }
    return _pathArrayM;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:panGesture];
    self.lineWidth = 10;
    self.lineColor = [[UIColor redColor] colorWithAlphaComponent:.7];
}

- (void)panGesture:(UIPanGestureRecognizer *)sender {
    CGPoint currentPoint = [sender locationInView:self];
    if (sender.state == UIGestureRecognizerStateBegan) {
        BezierPath * path = [BezierPath bezierPath];
        path.lineWidth = self.lineWidth;
        path.lineColor = self.lineColor;
        path.lineJoinStyle = kCGLineJoinRound;
        path.lineCapStyle = kCGLineCapRound;
        self.path = path;
        [path moveToPoint:currentPoint];
        [self.pathArrayM addObject:path];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        [self.path addLineToPoint:currentPoint];
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    for (BezierPath * path in self.pathArrayM) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage * image = (UIImage *)path;
            [image drawInRect:rect];
        } else {
            [path.lineColor set];
            [path stroke];
        }
    }
}

@end

@interface DrawView4 : UIView
@property (nonatomic, assign) CGFloat offsetX;
@property (nonatomic, weak)  CADisplayLink * link;
@end

@implementation DrawView4

- (void)dealloc {
    [self.link invalidate];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    CADisplayLink * link = [CADisplayLink displayLinkWithTarget:[Proxy proxyWithTarget:self] selector:@selector(update)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _link = link;
}

- (void)drawRect:(CGRect)rect {
    UIImage * image = [UIImage imageNamed:@"Resize"];
    [image drawAtPoint:CGPointMake(_offsetX, 0)];
}

- (void)update {
    _offsetX += 10;
    if (_offsetX > self.bounds.size.width) {
        _offsetX = 0;
    }
    [self setNeedsDisplay];
}

@end

@interface DrawView3 : UIView @end
@implementation DrawView3

- (void)drawRect:(CGRect)rect {
    CGPoint center = CGPointMake(rect.size.width * .5, rect.size.width * .5);
    CGFloat radius = rect.size.width * .5 - 10;
    __block CGFloat startAngle = 0.;
    __block CGFloat angle = .0;
    __block CGFloat endAngle = -M_PI_2;
    [@[@20, @18, @16, @14, @12] enumerateObjectsUsingBlock:^(NSNumber * num, NSUInteger idx, BOOL * _Nonnull stop) {
        startAngle = endAngle;
        angle = num.integerValue / 100.0 * M_PI * 2;
        endAngle = startAngle + angle;
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        [[self calculateColorWithRatio:num.floatValue] set];
        [path addLineToPoint:center];
        [path fill];
    }];
    
    NSString * text = @"Pie Chart";
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15.]} context:nil].size;
    NSMutableDictionary * attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:15.];
    attributes[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    attributes[NSStrokeColorAttributeName] = [UIColor blackColor];
    attributes[NSStrokeWidthAttributeName] = @3.;
    NSShadow * shadow = [NSShadow new];
    shadow.shadowColor = [UIColor whiteColor];
    shadow.shadowOffset = CGSizeMake(2, 2);
    attributes[NSShadowAttributeName] = shadow;
    //    [text drawInRect:rect withAttributes:attributes];
    [text drawAtPoint:CGPointMake((rect.size.width - size.width) * .5, (rect.size.height - size.height) * .5) withAttributes:attributes];
}

- (UIColor *)calculateColorWithRatio:(CGFloat)ratio {
    //    CGFloat r = arc4random_uniform(256) / 255.;
    //    CGFloat g = arc4random_uniform(256) / 255.;
    //    CGFloat b = arc4random_uniform(256) / 255.;
    //    CGFloat value = (arc4random() % 100 + 130) / 255.;
    CGFloat value = (255. - (ratio * 10) + 70.) / 255.;
    return [UIColor colorWithRed:value green:value blue:value alpha:1.];
}

@end

@interface DrawView2 : UIView
@property (nonatomic, weak) IBOutlet UILabel * valueLabel;
@property (nonatomic, assign) CGFloat value;
@end

@implementation DrawView2

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSetting];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self defaultSetting];
}

- (void)defaultSetting {
    _value = .6666;
    self.valueLabel.text = [NSString stringWithFormat:@"%.2f%%", _value * 100];
}

- (void)drawRect:(CGRect)rect {
    CGPoint center = CGPointMake(rect.size.width * .5, rect.size.height * .5);
    CGFloat radius = rect.size.width * .5 - 10;
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = startAngle + _value * M_PI * 2;
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [path addLineToPoint:center];
    [path closePath];
    [[[UIColor darkGrayColor] colorWithAlphaComponent:.6] set];
    [path fill];
}

- (IBAction)valueChanged:(UISlider *)sender {
    NSLog(@"%f", sender.value);
    self.valueLabel.text = [NSString stringWithFormat:@"%.2f%%", sender.value * 100];
    _value = sender.value;
    [self setNeedsDisplay];
}

@end

@interface DrawView : UIView @end
@implementation DrawView

- (void)drawRect:(CGRect)rect {
    Log
    NSLog(@"%@", NSStringFromCGRect(rect));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, 10, 10);
    CGContextScaleCTM(ctx, .8, .8);
    CGContextRotateCTM(ctx, M_PI * 2);
    CGContextSaveGState(ctx);
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 10)];
    [path addLineToPoint:CGPointMake(90, 90)];
    [path addLineToPoint:CGPointMake(10, 90)];
    [path moveToPoint:CGPointMake(10, 90)];
    [path addLineToPoint:CGPointMake(90, 10)];
    [path addLineToPoint:CGPointMake(10, 10)];
    CGContextSetLineWidth(ctx, 5.);
#if 0
    /* Line join styles. */
    typedef CF_ENUM(int32_t, CGLineJoin) {
        kCGLineJoinMiter,
        kCGLineJoinRound,
        kCGLineJoinBevel
    };
    /* Line cap styles. */
    typedef CF_ENUM(int32_t, CGLineCap) {
        kCGLineCapButt,
        kCGLineCapRound,
        kCGLineCapSquare
    };
#endif
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //    [[UIColor darkGrayColor]setStroke];
    //    [[UIColor lightGrayColor]setFill];
    CGContextAddPath(ctx, path.CGPath);
    
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(-10, 30)];
    [path2 addQuadCurveToPoint:CGPointMake(110, 30) controlPoint:CGPointMake(50, 80)];
    CGContextAddPath(ctx, path2.CGPath);
    
    //    UIBezierPath * path3 = [UIBezierPath bezierPathWithRect:rect];
    //    UIBezierPath * path3 = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:50];
    UIBezierPath * path3 = [UIBezierPath bezierPathWithOvalInRect:rect];
    CGContextAddPath(ctx, path3.CGPath);
    [[[UIColor darkGrayColor] colorWithAlphaComponent:.7] set];
    //    CGContextStrokePath(ctx);
    //    CGContextFillPath(ctx);
    [path fill];
    CGContextRestoreGState(ctx);
    [path2 stroke];
    [path3 stroke];
}

@end
