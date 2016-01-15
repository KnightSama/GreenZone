//
//  CityMsgTableViewController.h
//  GreenZone
//
//  Created by niit on 15-7-6.
//  Copyright (c) 2015年 student. All rights reserved.
//

#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0   //屏幕适配，自动计算不同屏幕对应的x和y方向的坐标
#define H(y) WinHeight*y/568.0

#import <UIKit/UIKit.h>
@class Save;
@class CityModel;
@class AVAudioPlayer;

@interface CityMsgTableViewController : UITableViewController
/**
 *  选中的城市
 */
@property(nonatomic,strong) CityModel *city;

/**
 *  税收标签
 */
@property(nonatomic,strong) UILabel *moneyLabel;
/**
 *  威望标签
 */
@property(nonatomic,strong) UILabel *manaLabel;

/**
 *  存档信息
 */
@property(nonatomic,strong)Save *save;

/**
 *  拥有的城市
 */
@property(nonatomic,strong)NSArray *cities;

/**
 *  弹出的View
 */
@property(nonatomic,strong) UIView *showView;

/**
 *  音乐
 */
@property(nonatomic,strong) AVAudioPlayer *player;

/**
 *  通过存档保存数据
 */
-(instancetype)initWithSave:(Save *)save;

@end
