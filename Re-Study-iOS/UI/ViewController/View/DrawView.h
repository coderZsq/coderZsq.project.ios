//
//  DrawView.h
//  UI
//
//  Created by 朱双泉 on 2018/9/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HandleView;
@protocol HandleViewDelegate <NSObject>
- (void)handleView:(HandleView *)handleView image:(UIImage *)image;
@end

@interface DrawView5 : UIView <HandleViewDelegate>

@property (nonatomic, strong) UIImage * image;

- (void)clear;

- (void)undo;

-(void)eraser;

- (void)setLineWidth:(CGFloat)width;

- (void)setLineColor:(UIColor *)color;

@end

@interface HandleView : UIView

@property (nonatomic, strong) UIImage * image;
@property (nonatomic, weak) id<HandleViewDelegate> delegate;

@end
