//
//  BattleViewController.h
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
@class MonsterModel;
@class AVAudioPlayer;
@protocol BattleViewControllerDelegate <NSObject>

/**
 *  战斗结果  @0游戏结束  @1胜利  @2攻城失败
 */
-(void)battleViewPassMessage:(NSString *)message withResult:(NSNumber *)result;

@end

@interface BattleViewController : UIViewController
@property(nonatomic,strong) AVAudioPlayer *player;
/**
 *  存档信息
 */
@property(nonatomic,strong) Save *save;

/**
 *  事件信息
 */
@property(nonatomic,strong) NSNumber *number;

/**
 *获取怪物信息
 */
@property(nonatomic,strong)NSArray *monsters;

/**
 *获取小怪信息
 */
@property(nonatomic,strong)NSMutableArray *smallMonsters;

/**
 *获取BOSS信息
 */
@property(nonatomic,strong)NSMutableArray *BOSS;

/**
 *保存当前怪物信息
 */
@property(nonatomic,strong)MonsterModel *currentMonster;

@property(nonatomic,weak) id<BattleViewControllerDelegate> delegate;

/**
 *  通过存档初始化
 */
-(instancetype)initWithSave:(Save *)save andNumber:(NSNumber *)number;

@end
