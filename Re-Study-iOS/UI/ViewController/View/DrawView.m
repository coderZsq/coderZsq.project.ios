//
//  DrawView.m
//  UI
//
//  Created by 朱双泉 on 2018/9/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Proxy.h"

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
    CGFloat value = (255. - (25. + ratio * 5)) / 255.;
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
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 20)];
    [path addLineToPoint:CGPointMake(80, 80)];
    [path addLineToPoint:CGPointMake(20, 80)];
    [path moveToPoint:CGPointMake(20, 80)];
    [path addLineToPoint:CGPointMake(80, 20)];
    [path addLineToPoint:CGPointMake(20, 20)];
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
    [path2 moveToPoint:CGPointMake(0, 30)];
    [path2 addQuadCurveToPoint:CGPointMake(100, 30) controlPoint:CGPointMake(50, 75)];
    CGContextAddPath(ctx, path2.CGPath);
    
    //    UIBezierPath * path3 = [UIBezierPath bezierPathWithRect:rect];
    //    UIBezierPath * path3 = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:50];
    UIBezierPath * path3 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 80, 80)];
    CGContextAddPath(ctx, path3.CGPath);
    [[[UIColor darkGrayColor] colorWithAlphaComponent:.7] set];
    //    CGContextStrokePath(ctx);
    //    CGContextFillPath(ctx);
    [path fill];
    [path2 stroke];
    [path3 stroke];
}

@end
