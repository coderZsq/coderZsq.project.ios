//
//  UIImageView+SQFetcher.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/8/23.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "UIImageView+SQFetcher.h"
#import "SQFetcher.h"

@implementation UIImageView (SQFetcher)

- (void)sq_imageWithURLString:(NSString *)URLString {
    [SQFetchManager managerWithState:SQFetchConcurrentState]
    .GET(URLString, nil, ^(UIImage *responseObject){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = responseObject;
        });
    },nil);
}

@end
