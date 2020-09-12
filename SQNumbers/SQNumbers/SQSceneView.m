//
//  SQSceneView.m
//  SQNumbers
//
//  Created by 朱双泉 on 2020/9/11.
//  Copyright © 2020 朱双泉. All rights reserved.
//

#import "SQSceneView.h"
#import "SQSpriteView.h"

@implementation SQSceneView

- (void)renderToCanvas:(UIView *)superView {
    [superView addSubview:self];
    
    NSInteger capacity = self.capacity ? self.capacity : 5;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:capacity];
    
    UIView *containerView = [UIView new];
    CGFloat containerViewW = self.bounds.size.width * 0.9;
    CGFloat containerViewH = containerViewW * 0.2;
    CGFloat containerViewX = (self.bounds.size.width - containerViewW) * 0.5;
    CGFloat containerViewY = (self.bounds.size.height - containerViewH) * 0.5;
    containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);
    [self addSubview:containerView];
    
    CGFloat innerViewW = containerViewH - 20;
    CGFloat innerViewH = innerViewW;
    CGFloat innerViewY = (containerViewH - innerViewH) * 0.5;
    CGFloat innerViewS = (containerViewW - (innerViewW * capacity)) / (capacity + 1);
    CGFloat spriteViewW = innerViewW - 20;
    CGFloat spriteViewH = spriteViewW;
    for (NSInteger i = 0; i < capacity; i++) {
        UIView *innerView = [UIView new];
        CGFloat innerViewX = innerViewS + (i * (innerViewW + innerViewS));
        innerView.backgroundColor = [UIColor lightGrayColor];
        innerView.frame = CGRectMake(innerViewX, innerViewY, innerViewW, innerViewH);
        [containerView addSubview:innerView];
        
        UILabel *innerLabel = [UILabel new];
        innerLabel.text = @(i + 1).stringValue;
        innerLabel.textAlignment = NSTextAlignmentCenter;
        innerLabel.font = [UIFont boldSystemFontOfSize:120];
        innerLabel.frame = innerView.bounds;
        [innerView addSubview:innerLabel];
        
        SQSpriteView *spriteView = [SQSpriteView new];
        spriteView.matchRect = [innerView.superview convertRect:innerView.frame toView:self];
        spriteView.backgroundColor = [UIColor systemGreenColor];
        NSString *address = [NSString stringWithFormat:@"%p", spriteView];
        dict[address] = @(NO);
        
        spriteView.matching = ^(SQSpriteView *matchView) {
            if (matchView.isMatch) {
                matchView.matched = YES;
                dict[address] = @(YES);
            }
            BOOL successed = YES;
            for (NSNumber *num in dict.allValues) {
                if (!num.boolValue) {
                    successed = NO;
                }
            }
            if (successed) {
                NSLog(@"游戏通关");
            }
        };
        
        CGFloat spriteViewX = arc4random() % (int)(self.bounds.size.width - spriteViewW);
        CGFloat spriteViewY = arc4random() % (int)(self.bounds.size.height - spriteViewH);
        spriteView.frame = CGRectMake(spriteViewX, spriteViewY, spriteViewW, spriteViewH);
        [self addSubview:spriteView];
        
        UILabel *spriteLabel = [UILabel new];
        spriteLabel.text = innerLabel.text;
        spriteLabel.textAlignment = innerLabel.textAlignment;
        spriteLabel.font = innerLabel.font;
        spriteLabel.frame = spriteView.bounds;
        [spriteView addSubview:spriteLabel];
    }
}

@end
