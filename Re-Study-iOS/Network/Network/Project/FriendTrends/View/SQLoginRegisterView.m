//
//  SQLoginRegisterView.m
//  Network
//
//  Created by 朱双泉 on 2018/10/15.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQLoginRegisterView.h"

@interface SQLoginRegisterView ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation SQLoginRegisterView

+ (instancetype)loginView {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}

+ (instancetype)registerView {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImage * image = self.loginButton.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * .5 topCapHeight:image.size.height * .5];
    [self.loginButton setBackgroundImage:image forState:UIControlStateNormal];
}

@end
