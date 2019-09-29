//
//  SQAddConnectionViewController.h
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/24.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SQConnectionModel;

@interface SQConnectionEventsViewController : UITableViewController

@property (nonatomic, strong) SQConnectionModel *connection;

@end

NS_ASSUME_NONNULL_END
