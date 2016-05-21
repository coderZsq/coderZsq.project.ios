//
//  SQPaintView.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQPaintView.h"
#import "UIImage+SQExtension.h"

@interface SQPaintView()

@property (nonatomic, strong) NSMutableArray * linePaths;

@end

@implementation SQPaintView

- (NSMutableArray *)linePaths {
    
    if (!_linePaths) {
        _linePaths = @[].mutableCopy;
    }
    return _linePaths;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [touches anyObject];
    CGPoint   point = [touch locationInView:touch.view];
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [path moveToPoint:point];
    [self.linePaths addObject:path];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch = [touches anyObject];
    CGPoint   point = [touch locationInView:touch.view];
    
    UIBezierPath * path = [self.linePaths lastObject];
    [path addLineToPoint:point];
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}

- (void)drawRect:(CGRect)rect {
    
    [self.lineColor set];
    [self.linePaths enumerateObjectsUsingBlock:^(UIBezierPath * path, NSUInteger idx, BOOL * stop) {
        [path setLineWidth:self.lineWidth];
        [path stroke];
    }];
}

- (void)clear {
    [self.linePaths removeAllObjects];
    [self setNeedsDisplay];
}

- (void)back {
    [self.linePaths removeLastObject];
    [self setNeedsDisplay];
}

- (void)save {
    UIImageWriteToSavedPhotosAlbum([UIImage imageCaptureWithView:self], self, nil, nil);
}

@end
