//
//  SQCopyLabel.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQCopyLabel.h"

@implementation SQCopyLabel

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self attachTapHandler];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder  {
    
    self = [super initWithCoder:coder];
    if (self) {
        [self attachTapHandler];
    }
    return self;
}

- (void)attachTapHandler {
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)]];
}

- (void)longPress:(UIGestureRecognizer *)recognizer {

    [self becomeFirstResponder];
    UIMenuController * menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:CGRectMake(self.copyOffset, 0, 0, 0) inView:self];
    [menu setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copy:));
}

- (void)copy:(id)sender {
    UIPasteboard * pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.text;
}

@end
