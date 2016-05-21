//
//  SQRemovableBadgeView.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SQBadgeViewAlignment) {
    
    SQBadgeViewAlignmentTopLeft = 0,
    SQBadgeViewAlignmentTopRight,
    SQBadgeViewAlignmentTopCenter,
    SQBadgeViewAlignmentCenter,
    SQBadgeViewAlignmentCenterLeft,
    SQBadgeViewAlignmentCenterRight,
    SQBadgeViewAlignmentBottomLeft,
    SQBadgeViewAlignmentBottomRight,
    SQBadgeViewAlignmentBottomCenter
};


@interface SQRemovableBadgeView : UIView

@property (nonatomic,assign) SQBadgeViewAlignment badgeViewAlignment;

@property (nonatomic,strong) UIView   * attachView;

@property (nonatomic,strong) NSString * badgeText;

@property (nonatomic,assign) CGFloat    maxDistance;

@property (nonatomic,assign) BOOL       panable;


@property (nonatomic,assign) CGFloat    badgeViewCornerRadius;

@property (nonatomic,strong) UIColor  * badgeTextColor;

@property (nonatomic,strong) UIFont   * badgeTextFont;

@property (nonatomic,strong) UIColor  * badgeBackgroundColor;

@property (nonatomic,assign) CGSize     badgeTextShadowSize;

@property (nonatomic,strong) UIColor  * badgeTextShadowColor;

@property (nonatomic,strong) UIColor  * badgeShadowColor;

@property (nonatomic,assign) CGSize     badgeShadowSize;

@property (nonatomic,assign) CGFloat    badgeStrokeWidth;

@property (nonatomic,strong) UIColor  * badgeStrokeColor;

@property (nonatomic,assign) CGPoint    badgePositionAdjustment;

@property (nonatomic,assign) CGFloat    badgeMinWidth;

@end
