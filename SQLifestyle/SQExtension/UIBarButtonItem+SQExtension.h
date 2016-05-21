//
//  UIBarButtonItem+SQExtension.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SQExtension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action;

@end
