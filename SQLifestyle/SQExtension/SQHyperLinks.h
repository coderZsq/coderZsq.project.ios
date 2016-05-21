//
//  SQHyperLinks.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQHyperLinks : UIButton

@property (nonatomic,copy) NSString * hyperLink;

@property (nonatomic,strong) UIColor * hyperLinkColor;
@property (nonatomic,strong) UIColor * hyperLinkHighlightColor;

@property (nonatomic,strong) UIWebView * webView;

@end
