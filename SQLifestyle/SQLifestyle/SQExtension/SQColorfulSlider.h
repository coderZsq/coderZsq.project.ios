//
//  SQColorfulSlider.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQColorfulSlider : UIControl

@property (nonatomic, assign) CGFloat value;/* From 0 to 1 */

@property (nonatomic, assign) CGFloat middleValue;/* From 0 to 1 */

@property (nonatomic, strong) UIColor * minimumTrackTintColor;

@property (nonatomic, strong) UIColor * middleTrackTintColor;

@property (nonatomic, strong) UIColor * maximumTrackTintColor;

@end
