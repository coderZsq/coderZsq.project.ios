//
//  SQMagnetTitleView.h
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/14.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQMagnetTitleView : UIView

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

+ (instancetype)titleViewWithTitle:(NSString *)title image:(UIImage *)image rate:(NSString *)rate;

@end

NS_ASSUME_NONNULL_END
