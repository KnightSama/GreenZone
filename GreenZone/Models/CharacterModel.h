//
//  CharacterModel.h
//  Game
//
//  Created by niit on 15-6-30.
//  Copyright (c) 2015年 zw. All rights reserved.
//

/**
 *  本类是人物角色类，包含角色的各种属性
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CharacterModel : NSObject<NSCoding>


/**
 *  人物ID
 */
@property(nonatomic,strong)NSString *characterId;

/**
 *  人物姓名
 */
@property(nonatomic,strong)NSString *name;

/**
 *  人物图标图片的名字
 */
@property(nonatomic,strong)NSString *icon;

/**
 *  人物小图片的名字
 */
@property(nonatomic,strong)NSString *smallImage;

/**
 *  人物大图片名字
 */
@property(nonatomic,strong)NSString *bigImage;

/**
 *  人物脸部图片名字
 */
@property(nonatomic,strong)NSString *faceImage;

/**
 *  人物行动图片名字
 */
@property(nonatomic,strong)NSString *animationImage;

/**
 *  人物介绍
 */
@property(nonatomic,strong)NSString *characterDescription;

/**
 *  人物血量上限
 */
@property(nonatomic,strong)NSNumber *blood;

/**
 *  人物当前血量
 */
@property(nonatomic,strong)NSNumber *currentBlood;

/**
 *  人物统帅值
 */
@property(nonatomic,strong)NSNumber *leadAbility;

/**
 *  人物的攻击力
 */
@property(nonatomic,strong)NSNumber *attack;

/**
 *  人物的防御力
 */
@property(nonatomic,strong)NSNumber *defence;

/**
 *  人物携带的武将
 */
@property(nonatomic,strong)NSMutableArray *carryingGeneral;

/**
 *  人物拥有的武将
 */
@property(nonatomic,strong)NSMutableArray *allGeneral;

/**
 *  人物拥有的城市
 */
@property(nonatomic,strong)NSMutableArray *havingCities;

/**
 *  人物的士兵数
 */
@property(nonatomic,strong)NSNumber *soldierNum;

/**
 *  人物已装备的装备
 */
@property(nonatomic,strong)NSMutableArray *equiped;

/**
 *  人物的背包
 */
@property(nonatomic,strong)NSMutableDictionary *package;

/**
 *  任务列表
 */
@property(nonatomic,strong)NSMutableArray *tasksList;

/**
 *  金钱
 */
@property(nonatomic,strong)NSNumber *money;

/**
 *  剩余技能点
 */
@property(nonatomic,strong)NSNumber *skillPointRemaining;

/**
 *  技能列表
 */
@property(nonatomic,strong)NSMutableArray *skillsList;

/**
 *  行动力
 */
@property(nonatomic,strong)NSNumber *power;

/**
 *  不能行动的武将
 */
@property(nonatomic,strong)NSMutableArray *generalNoActing;

/**
 *  不能行动的士兵
 */
@property(nonatomic,strong)NSNumber *soldiersNoActing;

//下面为本类的方法

/**
 *  角色的初始化方法，通过字典初始化
 */
-(instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  通过调用私有的初始化方法，实现初始化方法，为类方法
 */
+(instancetype)characterWithDict:(NSDictionary *)dict;

/**
 *  返回所有本类的对象数组
 */
+(NSArray *)allCharactersList;


/**
 *  归档方法
 */
-(void)encodeWithCoder:(NSCoder *)aCoder;

/**
 *  解档方法
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder;



@end
