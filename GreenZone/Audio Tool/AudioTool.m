//
//  AudioTool.m
//  2、SystemSound封装
//
//  Created by niit on 15/5/28.
//  Copyright (c) 2015年 niit. All rights reserved.
//

#import "AudioTool.h"

@implementation AudioTool




+(SystemSoundID)playSystemSound:(NSString *)fileName{
    if (!fileName) {
        return 0;
    }
    SystemSoundID soundId;
    
    //加载url
    NSURL *fileUrl=[[NSBundle mainBundle]URLForResource:fileName withExtension:nil];
    if (!fileUrl) {
        return 0;
    }
    //创建系统音效
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileUrl, &soundId);
    //播放
    AudioServicesPlaySystemSound(soundId);
    return soundId;
}


//播放音乐
+(AVAudioPlayer *)playMusic:(NSString *)fileName{
    if (!fileName) {
        return nil;
    }
    AVAudioPlayer *player;
    NSURL *url=[[NSBundle mainBundle]URLForResource:fileName withExtension:nil];
    if (!url) {
        return nil;
    }
    player=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [player prepareToPlay];//准备播放，提前把这个音频文件放入缓存
    [player play];
    return player;
}

@end
