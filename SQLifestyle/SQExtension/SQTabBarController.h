//
//  SQTabBarController.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQTabBarController : UITabBarController

+ (instancetype)tabbarWithViewControllers:(NSArray *)viewcontrollers titles:(NSArray *)titles imageNames:(NSArray *)imageNames selectedImageNames:(NSArray *)selectedImageNames;

@end
