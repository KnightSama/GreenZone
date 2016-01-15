//
//  AboutUsViewController.h
//  GreenZone
//
//  Created by student on 15-7-6.
//  Copyright (c) 2015年 student. All rights reserved.
//
#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0  //屏幕适配，自动计算不同屏幕对应的x和y方向的坐标
#define H(y) WinHeight*y/568.0
#import <UIKit/UIKit.h>
@class AVAudioPlayer;
@interface AboutUsViewController : UIViewController

@property(nonatomic,strong) AVAudioPlayer *player;
@end
