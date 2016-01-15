//
//  RandomEventShowViewController.h
//  GreenZone
//
//  Created by student on 15/7/8.
//  Copyright (c) 2015年 student. All rights reserved.
//

#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0  //屏幕适配，自动计算不同屏幕对应的x和y方向的坐标
#define H(y) WinHeight*y/568.0
#import <UIKit/UIKit.h>
@class AVAudioPlayer;
@interface RandomEventShowViewController : UIViewController
@property(nonatomic,strong) AVAudioPlayer *player;
/**
 *  背景图
 */
@property(nonatomic,strong) UIImage *backImage;
/**
 *  传递来的信息
 */
@property(nonatomic,strong) NSString *message;
/**
 *  传递来的view
 */
@property(nonatomic,strong) UIView *showView;
/**
 *  通过消息初始化
 */
-(instancetype)initWithMessage:(NSString *)message withView:(UIView *)view;

@end
