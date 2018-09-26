//
//  SQSettingSwitchItem.h
//  UI
//
//  Created by 朱双泉 on 2018/9/26.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSettingRowItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQSettingSwitchItem : SQSettingRowItem

@property (nonatomic, assign, getter=isOn) BOOL on;

@end

NS_ASSUME_NONNULL_END
