//
//  MonsterModel.h
//  Game
//
//  Created by niit on 15-6-30.
//  Copyright (c) 2015年 zw. All rights reserved.
//


/**
 *  怪物类，包含怪物的各种属性
 */

#import <Foundation/Foundation.h>

@interface MonsterModel : NSObject


/**
 *  怪物Id
 */
@property(nonatomic,strong)NSString *monsterId;

/**
 *  怪物名字
 */
@property(nonatomic,strong)NSString *name;

/**
 *  怪物图标图片名字
 */
@property(nonatomic,strong)NSString *icon;

/**
 *  怪物图片名字
 */
@property(nonatomic,strong)NSString *image;

/**
 *  怪物介绍
 */
@property(nonatomic,strong)NSString *monsterDescription;

/**
 *  怪物攻击力
 */
@property(nonatomic,strong)NSNumber *attack;

/**
 *  怪物防御力
 */
@property(nonatomic,strong)NSNumber *defence;

/**
 *  怪物血量
 */
@property(nonatomic,strong)NSNumber *blood;

/**
 *  怪物血量
 */
@property(nonatomic,strong)NSNumber *currentBlood;

/**
 *  怪物可能爆出的物品
 */
@property(nonatomic,strong)NSMutableArray *items;




/**
 *  初始化方法
 */
-(instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  通过初始化方法实现类的类初始化方法
 */
+(instancetype)monsterWithDict:(NSDictionary *)dict;

/**
 *  返回所有怪物对象数组
 */
+(NSArray *)allMonstersList;


@end
