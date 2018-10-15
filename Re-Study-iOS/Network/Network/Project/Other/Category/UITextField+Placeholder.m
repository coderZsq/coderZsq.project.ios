//
//  UITextField+Placeholder.m
//  Network
//
//  Created by 朱双泉 on 2018/10/15.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "UITextField+Placeholder.h"

@implementation UITextField (Placeholder)

- (UIColor *)placeholderColor {
    UILabel * label = [self valueForKeyPath:@"placeholderLabel"];
    return label.textColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    if (self.placeholder.length == 0) {
        self.placeholder = @" ";
    }
    UILabel * label = [self valueForKeyPath:@"placeholderLabel"];
    label.textColor = placeholderColor;
}

@end
