//
//  NSDate+Date.h
//  Network
//
//  Created by 朱双泉 on 2018/10/22.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Date)

- (BOOL)isThisYear;

- (BOOL)isThisToday;

- (BOOL)isThisYesterday;

- (NSDateComponents *)detalWithNow;

@end

NS_ASSUME_NONNULL_END
