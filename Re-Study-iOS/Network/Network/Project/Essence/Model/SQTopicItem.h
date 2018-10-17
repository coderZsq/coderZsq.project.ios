//
//  SQTopicItem.h
//  Network
//
//  Created by 朱双泉 on 2018/10/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SQTopicItemTypeAll = 1,
    SQTopicItemTypePicture = 10,
    SQTopicItemTypeVideo = 41,
    SQTopicItemTypeVoice = 31,
    SQTopicItemTypeText = 29
} SQTopicItemType;

@interface SQTopicItem : NSObject

@property (nonatomic, strong) NSString * profile_image;
@property (nonatomic, strong) NSString * screen_name;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) NSString * create_time;

@property (nonatomic, strong) NSString * image0;
@property (nonatomic, assign) BOOL is_gif;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) SQTopicItemType type;
@property (nonatomic, assign) BOOL is_bigPicture;

@property (nonatomic, strong) NSString * playcount;
@property (nonatomic, strong) NSString * videouri;
@property (nonatomic, assign) NSInteger videotime;

@property (nonatomic, strong) NSString * voiceuri;
@property (nonatomic, assign) NSInteger voicetime;

@end

NS_ASSUME_NONNULL_END
