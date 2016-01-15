//
//  GeneralMsgTableViewController.h
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
@class GeneralModel;
@class Save;
@class AVAudioPlayer;

@interface GeneralMsgTableViewController : UITableViewController
/**
 *  存档信息
 */
@property(nonatomic,strong) Save *save;

/**
 *  拥有的武将
 */
@property(nonatomic,strong)NSArray *generals;
/**
 *  要操作的武将
 */
@property(nonatomic,strong) GeneralModel *general;
/**
 *  弹出的视图
 */
@property(nonatomic,strong) UIView *showView;
/**
 *  显示花费的标签
 */
@property(nonatomic,strong) UILabel *moneyLabel;

/**
 *  音乐
 */
@property(nonatomic,strong) AVAudioPlayer *player;

/**
 *  通过存档初始化
 */
-(instancetype)initWithSave:(Save *)save;
@end
