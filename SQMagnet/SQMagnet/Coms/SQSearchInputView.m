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
#import "SQMagnetViewController.h"

@interface SQSearchInputView () <UITextFieldDelegate>

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
    self.textField.delegate = self;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon"]];
    UIView *leftView = [UIView new];
    leftView.frame = CGRectMake(5, 0, imageView.width + 10, self.textField.height);
    imageView.center = leftView.center;
    [leftView addSubview:imageView];
    self.textField.leftView = leftView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.dict = @{}.mutableCopy;
        NSArray *listArr = @[@"SQChartList", @"SQTop250List", @"SQMovie最新List", @"SQMovie冷门佳片List", @"SQMovie华语List", @"SQMovie日本List", @"SQMovie欧美List", @"SQMovie热门List", @"SQMovie韩国List", @"SQMovie高分List", @"SQTv国产剧List", @"SQTv日剧List", @"SQTv日本动画List", @"SQTv热门List", @"SQTv纪录片List", @"SQTv综艺List", @"SQTv美剧List", @"SQTv韩剧List"];
        for (NSUInteger i = 0; i < listArr.count; i++) {
            [[NSArray arrayWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:listArr[i] ofType:@"plist"]] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.dict setObject:obj forKey:obj[@"title"]];
            }];
        }
    });
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    SQMagnetViewController *magnetVC = [[UIStoryboard storyboardWithName:NSStringFromClass(SQMagnetViewController.class) bundle:nil] instantiateInitialViewController];
    magnetVC.query = textField.text;
    magnetVC.rate = [NSString stringWithFormat:@"%@分", self.dict[textField.text][@"rate"] ?: @"暂无评"];
    magnetVC.dict = self.dict[textField.text];
    textField.text = nil;
    [[self getCurrentViewController] presentViewController:magnetVC animated:YES completion:nil];
    return YES;
}

@end
