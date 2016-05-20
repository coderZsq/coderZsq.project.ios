//
//  SQViewControllerManager.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SQTableViewController;

@interface SQViewControllerManager : NSObject

@property (nonatomic,strong) SQTableViewController * currentViewController;

+ (SQViewControllerManager *)shareInstance;

- (SQTableViewController *)currentViewController;

@end
