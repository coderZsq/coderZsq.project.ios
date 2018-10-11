//
//  UIBarButtonItem+Item.h
//  Network
//
//  Created by 朱双泉 on 2018/10/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Item)

+ (instancetype)itemWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage target:(nullable id)target action:(nullable SEL)action;

+ (instancetype)itemWithImage:(UIImage *)image selectImage:(UIImage *)highlightImage target:(nullable id)target action:(nullable SEL)action;

@end

NS_ASSUME_NONNULL_END
