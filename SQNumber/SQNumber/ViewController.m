//
//  ViewController.m
//  SQNumber
//
//  Created by 朱双泉 on 2020/9/11.
//  Copyright © 2020 朱双泉. All rights reserved.
//

#import "ViewController.h"
#import "SQSpriteView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger count = 2;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:count];
    
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
    CGFloat innerViewS = (containerViewW - (innerViewW * count)) / (count + 1);
    CGFloat movableViewW = innerViewW - 20;
    CGFloat movableViewH = movableViewW;
    for (NSInteger i = 0; i < count; i++) {
        UIView *innerView = [UIView new];
        innerView.tag = i + 1;
        CGFloat innerViewX = innerViewS + (i * (innerViewW + innerViewS));
        innerView.backgroundColor = [UIColor lightGrayColor];
        innerView.frame = CGRectMake(innerViewX, innerViewY, innerViewW, innerViewH);
        [containerView addSubview:innerView];
        
        UILabel *innerLabel = [UILabel new];
        innerLabel.text = @(innerView.tag).stringValue;
        innerLabel.textAlignment = NSTextAlignmentCenter;
        innerLabel.font = [UIFont boldSystemFontOfSize:120];
        innerLabel.frame = innerView.bounds;
        [innerView addSubview:innerLabel];
        
        SQSpriteView *movableView = [SQSpriteView new];
        movableView.matchRect = [innerView.superview convertRect:innerView.frame toView:self.view];
        movableView.backgroundColor = [UIColor systemGreenColor];
        NSString *address = [NSString stringWithFormat:@"%p", movableView];
        dict[address] = @(NO);
        
        movableView.matching = ^(SQSpriteView *matchView) {
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
        movableView.frame = CGRectMake(movableViewX, movableViewY, movableViewW, movableViewH);
        [self.view addSubview:movableView];
        
        UILabel *movableLabel = [UILabel new];
        movableLabel.text = innerLabel.text;
        movableLabel.textAlignment = innerLabel.textAlignment;
        movableLabel.font = innerLabel.font;
        movableLabel.frame = movableView.bounds;
        [movableView addSubview:movableLabel];
    }
}


@end
