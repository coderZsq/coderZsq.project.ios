//
//  Proxy.h
//  UI
//
//  Created by 朱双泉 on 2018/9/6.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Proxy : NSProxy
+ (instancetype)proxyWithTarget:(id)target;
@end
