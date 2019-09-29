//
//  SQSearchInputView.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/12.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQSearchInputView.h"
#import "UIColor+SQExtension.h"
#import "NSObject+SQExtension.h"
#import "UIView+SQExtension.h"

@interface SQSearchInputView ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSMutableDictionary *dict;

@end

@implementation SQSearchInputView

+ (instancetype)inputView {
    SQSearchInputView *inputView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
    [inputView hookApplicationWillEnterForeground];
    return inputView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon"]];
    UIView *leftView = [UIView new];
    leftView.frame = CGRectMake(5, 0, imageView.width + 10, self.textField.height);
    imageView.center = leftView.center;
    [leftView addSubview:imageView];
    self.textField.leftView = leftView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)hookApplicationWillEnterForeground {
    if (@available(iOS 13.0, *)) {
        self.textField.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return [[UIColor colorWithHexString:@"#1c1c1e"] colorWithAlphaComponent:0.7f];
            } else {
                return [[UIColor colorWithHexString:@"#eeeeef"] colorWithAlphaComponent:0.7f];
            }
        }];
        self.textField.textColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return [UIColor whiteColor];
            } else {
                return [UIColor blackColor];
            }
        }];
    }
}

@end
