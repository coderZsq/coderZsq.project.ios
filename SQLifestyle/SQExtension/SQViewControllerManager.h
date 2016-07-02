//
//  SQViewControllerManager.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQViewControllerManager : NSObject

@property (nonatomic,strong) UIViewController * currentViewController;

+ (SQViewControllerManager *)shareInstance;

- (UIViewController *)currentViewController;

@end
