//
//  StartViewController.h
//  GreenZone
//
//  Created by zqh on 15/6/15.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AVAudioPlayer;
@class CircleView;
@interface StartViewController : UIViewController
/**
 *  存放圆形图标的数组
 */
@property(nonatomic,strong) NSMutableArray *viewArr;
/**
 *  旋转图标视图
 */
@property(nonatomic,strong) CircleView *circleMenu;
/**
 *  标题视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *titleView;
/**
 *  中间的五角星视图
 */
@property(nonatomic,strong) UIImageView *starView;
/**
 *  声音图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *soundView;
/**
 *  设置图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *settingView;
/**
 *  音乐播放对象
 */
@property(nonatomic,strong) AVAudioPlayer *player;
@end
