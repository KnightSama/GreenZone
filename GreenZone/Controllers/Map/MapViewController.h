//
//  MapViewController.h
//  GreenZone
//
//  Created by zqh on 15/6/30.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScrollMapView;
@class Map;
@class DiceView;
@class Save;
@class AVAudioPlayer;
@class EventRecorded;
@interface MapViewController : UIViewController
/**
 *  地图事件数组
 */
@property(nonatomic,strong) NSArray *mapEventArr;
/**
 *  界面顶部视图
 */
@property(nonatomic,strong) UIView *upView;
/**
 *  界面左侧视图
 */
@property(nonatomic,strong) UIView *leftView;
/**
 *  界面下方视图
 */
@property(nonatomic,strong) UIView *downView;
/**
 *  地图视图
 */
@property(nonatomic,strong) ScrollMapView *mapView;
/**
 *  要加载的地图
 */
@property(nonatomic,strong) Map *map;
/**
 *  色子视图
 */
@property(nonatomic,strong) DiceView *diceView;
/**
 *  存档信息
 */
@property(nonatomic,strong) Save *gameSave;
/**
 *  头像显示框
 */
@property(nonatomic,strong) UIImageView *characterImage;
/**
 *  血量显示视图
 */
@property(nonatomic,strong) UIView *hpView;
/**
 *  显示血量的标签
 */
@property(nonatomic,strong) UILabel *hpLabel;
/**
 *  行动力显示视图
 */
@property(nonatomic,strong) UIView *activeView;
/**
 *  显示行动力的标签
 */
@property(nonatomic,strong) UILabel *activeLabel;
/**
 *  显示钱币的标签
 */
@property(nonatomic,strong) UILabel *moneyLabel;
/**
 *  音乐播放对象
 */
@property(nonatomic,strong) AVAudioPlayer *player;
/**
 *  事件消息对象
 */
@property(nonatomic,strong) EventRecorded *record;

/**
 *  由存档名创建控制器
 */
-(instancetype)initWithSave:(Save *)save;
@end
