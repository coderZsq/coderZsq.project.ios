//
//  SQSpriteView.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQSpriteView : UIView

@property (nonatomic, assign) CGRect matchRect;

@property (nonatomic, assign, getter=isMatch, readonly) BOOL match;

@property (nonatomic, copy) void(^matching)(SQSpriteView *);

@property (nonatomic, assign, getter=isMatched) BOOL matched;

@end

