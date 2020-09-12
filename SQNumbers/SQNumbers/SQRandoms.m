//
//  SQRandoms.m
//  SQNumbers
//
//  Created by 朱双泉 on 2020/9/12.
//  Copyright © 2020 朱双泉. All rights reserved.
//

#import "SQRandoms.h"

@implementation SQRandoms

+ (double)randomNumberFrom:(NSInteger)from to:(NSInteger)to accuracy:(NSInteger)accuracy {
    double num = (arc4random() % (to - from)) + from;
    for (NSInteger i = 1; i <= accuracy; i++) {
        num += (arc4random() % 10) / pow(10, i);
    }
    return num;
}

@end
