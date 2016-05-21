//
//  SQTabBar.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQTabBar;

@protocol SQTabBarDelegate <NSObject>

@optional
- (void)tabBar:(SQTabBar *)tabBar didSelectItemFrom:(NSInteger)preIndex to:(NSInteger)selectedIndex;

@end

@interface SQTabBar : UIView

@property (nonatomic, weak) id <SQTabBarDelegate> delegate;

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end
