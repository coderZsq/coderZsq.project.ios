//
//  SQH1TitleView.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQH1TitleView.h"

@interface SQH1TitleView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation SQH1TitleView

+ (instancetype)viewWithTitle:(NSString *)title {
    SQH1TitleView *titleView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
    titleView.titleLabel.text = title;
    return titleView;
}

@end
