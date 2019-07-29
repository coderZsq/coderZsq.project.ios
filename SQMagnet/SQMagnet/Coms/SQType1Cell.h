//
//  SQType1Cell.h
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/12.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SQType1CellBlock)(void);

@interface SQType1Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, copy) SQType1CellBlock viewAll;

@end

NS_ASSUME_NONNULL_END
