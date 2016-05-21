//
//  SQPageControl.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface SQPageControl : UIView

@property (nonatomic,assign) NSUInteger numberOfPages;

@property (nonatomic,assign) NSUInteger currentPage;

@property (nonatomic,assign) CGFloat    pageIndicatorSpacing;

@property (nonatomic,strong) UIImage * pageIndicatorTintImage;

@property (nonatomic,strong) UIImage * currentPageIndicatorTintImage;

@property (nonatomic,assign) BOOL       hidesForSinglePage;

@end
