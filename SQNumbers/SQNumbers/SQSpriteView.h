//
//  SQSpriteView.h
//  SQNumbers
//
//  Created by 朱双泉 on 2020/9/11.
//  Copyright © 2020 朱双泉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQSpriteView : UIView

@property (nonatomic, assign) CGRect matchRect;

@property (nonatomic, assign, getter=isMatch, readonly) BOOL match;

@property (nonatomic, copy) void(^matching)(SQSpriteView *);

@property (nonatomic, assign, getter=isMatched) BOOL matched;

@end

NS_ASSUME_NONNULL_END
