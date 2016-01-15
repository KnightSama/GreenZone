//
//  AttackCityBattleViewController.h
//  GreenZone
//
//  Created by student on 15-7-8.
//  Copyright (c) 2015年 student. All rights reserved.
//
#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0  //屏幕适配，自动计算不同屏幕对应的x和y方向的坐标
#define H(y) WinHeight*y/568.0
#import <UIKit/UIKit.h>
@class Save;
@class CityModel;
@class GeneralModel;
@class MapViewController;
@class AVAudioPlayer;

@protocol AttackCityBattleViewControllerDelegate <NSObject>

/**
 *  战斗结果  @0游戏结束  @1胜利  @2攻城失败
 */
-(void)battleViewPassMessage:(NSString *)message withResult:(NSNumber *)result;

@end
@interface AttackCityBattleViewController : UIViewController
@property(nonatomic,strong) AVAudioPlayer *player;

/**
 *  存档信息
 */
@property(nonatomic,strong) Save *save;

/**
 *  城市信息
 */
@property(nonatomic,strong) CityModel *city;

/**
 *  出战武将信息
 */
@property(nonatomic,strong) GeneralModel *atkGeneral;

/**
 *  出战士兵数量
 */
@property(nonatomic,strong) NSNumber *soliderNum;

@property(nonatomic,weak) id<AttackCityBattleViewControllerDelegate> delegate;

/**
 *  通过存档初始化
 */
-(instancetype)initWithSave:(Save *)save andCityModel:(CityModel *)city andAtkGeneral:(GeneralModel *)atkGeneral andSoliderNum:(NSNumber *)soliderNum;

@end
