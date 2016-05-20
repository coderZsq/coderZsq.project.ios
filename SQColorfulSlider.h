//
//  SQColorfulSlider.h
//  具有多个颜色的滑块
//
//  Created by mac on 13-11-20.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQColorfulSlider : UIControl

@property (nonatomic, assign) CGFloat value;/* From 0 to 1 */

@property (nonatomic, assign) CGFloat middleValue;/* From 0 to 1 */

@property (nonatomic, strong) UIColor * minimumTrackTintColor;

@property (nonatomic, strong) UIColor * middleTrackTintColor;

@property (nonatomic, strong) UIColor * maximumTrackTintColor;

@end
