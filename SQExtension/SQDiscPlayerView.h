//
//  SQDiscPlayerView.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQDiscPlayerView : UIView

@property (nonatomic,strong) UIImage * albumImage;

@property (nonatomic,assign) CGFloat rotationDuration;

@property (nonatomic,assign) BOOL isPlay;

- (void)play;

- (void)pause;

@end
