//
//  SQAudioTool.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SQAudioTool : NSObject

+ (void)playSound:(NSString *)filename;

+ (void)disposeSound:(NSString *)filename;

+ (AVAudioPlayer *)playMusic:(NSString *)filename;

+ (void)pauseMusic:(NSString *)filename;

+ (void)stopMusic:(NSString *)filename;

+ (AVAudioPlayer *)currentPlayingAudioPlayer;

@end
