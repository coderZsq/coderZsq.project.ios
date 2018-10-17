//
//  SQCommentItem.h
//  Network
//
//  Created by 朱双泉 on 2018/10/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQUserItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQCommentItem : NSObject

@property (nonatomic, strong) NSString * voiceuri;
@property (nonatomic, strong) NSString * voicetime;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) SQUserItem * user;

@property (nonatomic, strong) NSString * totalContent;

@end

NS_ASSUME_NONNULL_END
