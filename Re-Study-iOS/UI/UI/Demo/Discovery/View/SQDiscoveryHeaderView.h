//
//  SQDiscoveryHeaderView.h
//  UI
//
//  Created by 朱双泉 on 2018/9/25.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQDiscoveryHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@end

NS_ASSUME_NONNULL_END
