//
//  SQRandoms.h
//  SQNumbers
//
//  Created by 朱双泉 on 2020/9/12.
//  Copyright © 2020 朱双泉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQRandoms : NSObject

+ (double)randomNumberFrom:(NSInteger)from to:(NSInteger)to accuracy:(NSInteger)accuracy;

@end

NS_ASSUME_NONNULL_END
