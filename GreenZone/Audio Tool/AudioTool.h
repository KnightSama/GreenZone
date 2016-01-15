//
//  AudioTool.h
//  2、SystemSound封装
//
//  Created by niit on 15/5/28.
//  Copyright (c) 2015年 niit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioTool : NSObject

//播放系统音效
+(SystemSoundID)playSystemSound:(NSString *)fileName;

//播放音乐
+(AVAudioPlayer *)playMusic:(NSString *)fileName;

@end
