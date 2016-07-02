//
//  SQMacro.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#ifndef SQMacro_h
#define SQMacro_h

#import "SQViewControllerManager.h"
#import "SQTableViewSection.h"
#import "SQTableViewRow.h"
#import "SQTableViewController.h"
#import "SQTableViewCell.h"
#import "SQHeaderFooterView.h"
#import "SQViewController.h"
#import "SQVariableGlobal.h"
#import "SQImageGlobal.h"
#import "UIView+SQExtension.h"
#import "UIImage+SQExtension.h"
#import "UIColor+SQExtension.h"

#define SQAngle(x) ((x) / 180.0f * M_PI)
#define SQColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define SQScaleFont(size) [UIFont systemFontOfSize:(size)*[UIScreen mainScreen].bounds.size.width / 320.0f]

#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScaleLength(length) (length) * [UIScreen mainScreen].bounds.size.width / 320.0f

#define kSpace 8
#define kTimeInterval 0.25

#define KC01_57c2de [UIColor colorWithHexString:@"#57c2de"]
#define KC02_2c2c2c [UIColor colorWithHexString:@"#2c2c2c"]
#define KC03_666666 [UIColor colorWithHexString:@"#666666"]
#define KC04_999999 [UIColor colorWithHexString:@"#999999"]
#define KC05_dddddd [UIColor colorWithHexString:@"#dddddd"]

#define KF01_24px [UIFont systemFontOfSize:24]
#define KF02_18px [UIFont systemFontOfSize:18]
#define KF03_17px [UIFont systemFontOfSize:17]
#define KF04_15px [UIFont systemFontOfSize:15]
#define KF05_14px [UIFont systemFontOfSize:14]
#define KF06_12px [UIFont systemFontOfSize:12]

#define TABBAR_BGC SQColor(248, 248, 248, 1)
#define GLOBAL_BGC TABBAR_BGC

#define iOS7  [[UIDevice currentDevice]systemVersion].floatValue >= 7.0f
#define iOS8  [[UIDevice currentDevice]systemVersion].floatValue >= 8.0f
#define iOS9  [[UIDevice currentDevice]systemVersion].floatValue >= 9.0f
#define iOS10  [[UIDevice currentDevice]systemVersion].floatValue >= 10.0f

#ifdef DEBUG
#define SQLog(...) NSLog(__VA_ARGS__)
#else
#define SQLog(...)
#endif

#endif
