//
//  SQNewFeatureViewController.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SQNewFeatureViewControllerBlock)();

@interface SQNewFeatureViewController : UIViewController

@property (nonatomic,copy) SQNewFeatureViewControllerBlock block;

@property (nonatomic,strong) UIImage * enterButtonImage;

@property (nonatomic,strong) NSArray * newfeatureImages;

@end
