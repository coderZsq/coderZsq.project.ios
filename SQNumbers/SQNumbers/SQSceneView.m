//
//  SQSceneView.m
//  SQNumbers
//
//  Created by 朱双泉 on 2020/9/11.
//  Copyright © 2020 朱双泉. All rights reserved.
//

#import "SceneDelegate.h"
#import "SQSceneView.h"
#import "SQSpriteView.h"

@interface SQSceneView ()

@property (nonatomic, assign) NSInteger currnetLevel;

@end

@implementation SQSceneView

- (void)renderToCanvas:(UIView *)superView {
    [superView addSubview:self];
    
    self.currnetLevel += 1;
    NSInteger capacity = arc4random_uniform(5) + 1;
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
                UIAlertController *altvc = [UIAlertController alertControllerWithTitle:@"闯关成功" message:[NSString stringWithFormat:@"恭喜你通过第%li关, 请进入第%li关", self.currnetLevel, self.currnetLevel + 1] preferredStyle:UIAlertControllerStyleAlert];
                [altvc addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    for (UIView *view in self.subviews) {
                        [view removeFromSuperview];
                    }
                    [self renderToCanvas:superView];
                }]];
                NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
                UIWindowScene *windowScene = (UIWindowScene *)array.firstObject;
                SceneDelegate *delegate = (SceneDelegate *)windowScene.delegate;
                [delegate.window.rootViewController presentViewController:altvc animated:YES completion:nil];
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
