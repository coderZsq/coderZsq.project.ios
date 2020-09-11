//
//  SQScene.m
//  SQNumber
//
//  Created by 朱双泉 on 2020/9/11.
//  Copyright © 2020 朱双泉. All rights reserved.
//

#import "SQSceneView.h"
#import <UIKit/UIKit.h>

@implementation SQSceneView

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super init];
    if (self) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:capacity];
        
        UIView *containerView = [UIView new];
        CGFloat containerViewW = self.view.bounds.size.width * 0.9;
        CGFloat containerViewH = containerViewW * 0.2;
        CGFloat containerViewX = (self.view.bounds.size.width - containerViewW) * 0.5;
        CGFloat containerViewY = (self.view.bounds.size.height - containerViewH) * 0.5;
        containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);
        [self.view addSubview:containerView];
        
        CGFloat innerViewW = containerViewH - 20;
        CGFloat innerViewH = innerViewW;
        CGFloat innerViewY = (containerViewH - innerViewH) * 0.5;
        CGFloat innerViewS = (containerViewW - (innerViewW * capacity)) / (capacity + 1);
        CGFloat movableViewW = innerViewW - 20;
        CGFloat movableViewH = movableViewW;
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
            spriteView.matchRect = [innerView.superview convertRect:innerView.frame toView:self.view];
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
            
            CGFloat movableViewX = arc4random() % (int)(self.view.bounds.size.width - movableViewW);
            CGFloat movableViewY = arc4random() % (int)(self.view.bounds.size.height - movableViewH);
            spriteView.frame = CGRectMake(movableViewX, movableViewY, movableViewW, movableViewH);
            [self.view addSubview:spriteView];
            
            UILabel *movableLabel = [UILabel new];
            movableLabel.text = innerLabel.text;
            movableLabel.textAlignment = innerLabel.textAlignment;
            movableLabel.font = innerLabel.font;
            movableLabel.frame = spriteView.bounds;
            [spriteView addSubview:movableLabel];
        }
    }
    return self;
}

@end
