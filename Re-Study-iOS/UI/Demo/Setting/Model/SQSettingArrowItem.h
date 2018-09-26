//
//  SQSettingArrowItem.h
//  UI
//
//  Created by 朱双泉 on 2018/9/26.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQSettingRowItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQSettingArrowItem : SQSettingRowItem

@property (nonatomic, assign) Class destinationClass;
@property (nonatomic, copy) void(^destinationTask)(void);

@end

NS_ASSUME_NONNULL_END
