//
//  SQConnectionPropertyCell.h
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/24.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQConnectionPropertyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *inputLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

NS_ASSUME_NONNULL_END
