//
//  SQPolishButton.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SQPolishButtonOpreation)();

@interface SQPolishButton : UIButton

@property (nonatomic,strong) UIColor * color;

@property (nonatomic,copy) SQPolishButtonOpreation operation;

- (instancetype)initWithFrame:(CGRect)frame withColor:(UIColor *)color;

@end
