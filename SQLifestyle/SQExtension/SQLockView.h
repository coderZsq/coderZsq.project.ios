//
//  SQLockView.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQLockView;

@protocol SQLockViewDelegate <NSObject>

@optional
- (void)lockView:(SQLockView *)lockView didFinishPath:(NSString *)path;
@end

@interface SQLockView : UIView

@property (nonatomic,strong) UIImage * normalImage;

@property (nonatomic,strong) UIImage * highlightImage;

@property (nonatomic,strong) UIColor * pathColor;

@property (nonatomic,weak) id <SQLockViewDelegate> delegate;

@end
