//
//  SQSecondaryViewController.h
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SQSecondaryViewController;
@protocol SQSecondaryViewControllerDelegate <NSObject>
- (void)secondaryViewController:(SQSecondaryViewController *)secondaryViewController currentButtonIndex:(NSInteger)currentButtonIndex preButtonIndex:(NSInteger)preButtonIndex;
- (void)secondaryViewControllerDidClickedCityButton:(SQSecondaryViewController *)secondaryViewController;
@end

@interface SQSecondaryViewController : UIViewController
@property (nonatomic, weak) id<SQSecondaryViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
