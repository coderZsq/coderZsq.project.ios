//
//  UIImageView+load.m
//  SQTemplate
//
//  Created by 双泉 朱 on 17/5/8.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

#import "UIImageView+load.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (load)

- (void)loadUrl:(NSString *)imageUrl placeholder:(NSString *)placeholder {
    [self sd_setImageWithURL:[NSURL URLWithString:[imageUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:placeholder]];
}

@end
