//
//  LockView.m
//  UI
//
//  Created by 朱双泉 on 2018/9/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "LockView.h"

@interface LockView()
@property (nonatomic, strong) NSMutableArray * selectButtonArrayM;
@property (nonatomic, assign) CGPoint currentPoint;
@end

@implementation LockView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (NSMutableArray *)selectButtonArrayM {
    
    if (!_selectButtonArrayM) {
        _selectButtonArrayM = @[].mutableCopy;
    }
    return _selectButtonArrayM;
}

- (CGPoint)getCurrentPointWithTouches:(NSSet *)touches {
    UITouch * touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    return currentPoint;
}

- (UIButton *)buttonRectContainsPoint:(CGPoint)point {
    for (UIButton * button in self.subviews) {
        if (CGRectContainsPoint(button.frame, point)) {
            return button;
        }
    }
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint currentPoint = [self getCurrentPointWithTouches:touches];
    UIButton * button = [self buttonRectContainsPoint:currentPoint];
    if (button) {
        [self.selectButtonArrayM addObject:button];
        button.selected = YES;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint currentPoint = [self getCurrentPointWithTouches:touches];
    self.currentPoint = currentPoint;
    UIButton * button = [self buttonRectContainsPoint:currentPoint];
    if (button && !button.selected) {
        [self.selectButtonArrayM addObject:button];
        button.selected = YES;
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSMutableString * str = @"".mutableCopy;
    for (UIButton * button in self.selectButtonArrayM) {
        button.selected = NO;
        [str appendFormat:@"%ld", button.tag];
    }
    NSLog(@"%@", str);
    [self.selectButtonArrayM removeAllObjects];
    [self setNeedsDisplay];
}

- (void)setupSubviews {
    for (NSInteger i = 0; i < 9; i++) {
        UIButton * button = [UIButton new];
        button.tag = i;
        [button setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        button.userInteractionEnabled = NO;
        [self addSubview:button];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger column = 3;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = 74;
    CGFloat buttonH = buttonW;
    CGFloat margin = (self.bounds.size.width - column * buttonW) / (column + 1);
    NSUInteger currentColumn = 0;
    NSUInteger currentRow = 0;
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        currentColumn = i % column;
        currentRow = i / column;
        buttonX = margin + (buttonW + margin) * currentColumn;
        buttonY = margin + (buttonH + margin) * currentRow;
        UIButton * button = self.subviews[i];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}


- (void)drawRect:(CGRect)rect {
    if (!self.selectButtonArrayM.count) return;
    UIBezierPath * path = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i < self.selectButtonArrayM.count; i++) {
        UIButton * button = self.selectButtonArrayM[i];
        if (i == 0) {
            [path moveToPoint:button.center];
        } else {
            [path addLineToPoint:button.center];
        }
    }
    [path addLineToPoint:self.currentPoint];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineWidth:10];
    [[[UIColor lightGrayColor] colorWithAlphaComponent:.5] set];
    [path stroke];
}
@end
