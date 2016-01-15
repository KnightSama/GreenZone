//
//  CityEventViewController.h
//  GreenZone
//
//  Created by student on 15/7/7.
//  Copyright (c) 2015年 student. All rights reserved.
//
#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0  //屏幕适配，自动计算不同屏幕对应的x和y方向的坐标
#define H(y) WinHeight*y/568.0
#import <UIKit/UIKit.h>
#import "CheckGeneralTableViewController.h"
@class Save;
@class CityModel;
@class AVAudioPlayer;

@protocol cityEventViewControllerDelegate <NSObject>

-(void)cityEventDelegatePassSave:(Save *)save  withCity:(CityModel *)city withGeneral:(GeneralModel *)general  withSoldierNum:(NSNumber *)number;

@end

@interface CityEventViewController : UIViewController<checkGeneralDelegate>
@property(nonatomic,strong) AVAudioPlayer *player;
/**
 *  携带士兵数标签
 */
@property(nonatomic,strong) UILabel *carraySoldierLabel;
/**
 *  驻守士兵数标签
 */
@property(nonatomic,strong) UILabel *soldierLabel;

/**
 *  选择出战士兵数标签
 */
@property(nonatomic,strong) UILabel *checkSoldierLabel;
/**
 *  选择武将标签
 */
@property(nonatomic,strong) UILabel *generalLabel;
/**
 *  要操作的城市
 */
@property(nonatomic,strong) CityModel *city;
/**
 *  要操作的城市编号
 */
@property(nonatomic,strong) NSNumber *number;
/**
 *  要操作的存档
 */
@property(nonatomic,strong) Save *save;
/**
 要要显示的背景
 */
@property(nonatomic,strong) UIImage *backImage;
/**
 *  选择兵力条
 */
@property(nonatomic,strong) UISlider *soldierSlide;

/**
 *  已选择的武将
 */
@property(nonatomic,strong)GeneralModel *checkedGeneral;

/**
 *  显示剩余钱的label
 */
@property(nonatomic,strong)UILabel *moneyLabel;

/**
 *  显示征兵数的label
 */
@property(nonatomic,strong)UILabel *collectNumLabel;
/**
 *  征兵数字条
 */
@property(nonatomic,strong)UISlider *collectSlide;
/**
 *  驻守武将label
 */
@property(nonatomic,strong)UILabel *residenceGeneralLabel;
/**
 代理
 */
@property(nonatomic,weak) id<cityEventViewControllerDelegate> delegate;
/**
 *  通过视图初始化
 */
-(instancetype)initWithView:(UIView *)view WithNumber:(NSNumber *)number withSave:(Save *)save;
@end
