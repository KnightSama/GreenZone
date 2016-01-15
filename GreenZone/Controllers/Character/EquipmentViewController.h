//
//  EquipmentViewController.h
//  GreenZone
//
//  Created by student on 15-7-7.
//  Copyright (c) 2015年 student. All rights reserved.
//
#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0  //屏幕适配，自动计算不同屏幕对应的x和y方向的坐标
#define H(y) WinHeight*y/568.0
#import <UIKit/UIKit.h>
@class Save;
@class AVAudioPlayer;
@interface EquipmentViewController : UIViewController
/**
 *  存档信息
 */
@property(nonatomic,strong) Save *save;

/**
 *  物品数组
 */
@property(nonatomic,strong) NSArray *thingsArr;

/**
 *  武器数组
 */
@property(nonatomic,strong) NSMutableArray *weaponArr;

/**
 *  防具数组
 */
@property(nonatomic,strong) NSMutableArray *armorArr;

/**
 *  宝石数组
 */
@property(nonatomic,strong) NSMutableArray *gemArr;

/**
 *  音乐
 */
@property(nonatomic,strong) AVAudioPlayer *player;

/**
 *  通过存档初始化
 */
-(instancetype)initWithSave:(Save *)save;
@end
