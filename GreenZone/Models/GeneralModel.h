//
//  GeneralModel.h
//  Game
//
//  Created by niit on 15-6-30.
//  Copyright (c) 2015年 zw. All rights reserved.
//


/**
 *  本类是武将类，包含武将个各种属性
 */

#import <Foundation/Foundation.h>

@interface GeneralModel : NSObject<NSCoding>

/**
 *  武将Id
 */
@property(nonatomic,strong)NSString *generalId;

/**
 *  武将名字
 */
@property(nonatomic,strong)NSString *name;

/**
 *  武将图标图片名字
 */
@property(nonatomic,strong)NSString *icon;

/**
 *  武将图片名字
 */
@property(nonatomic,strong)NSString *image;

/**
 *  武将介绍
 */
@property(nonatomic,strong)NSString *generalDescription;

/**
 *  武将攻击力
 */
@property(nonatomic,strong)NSNumber *attack;

/**
 *  武将防御力
 */
@property(nonatomic,strong)NSNumber *defence;

/**
 *  武将体力值
 */
@property(nonatomic,strong)NSNumber *power;

/**
 *  武将最大携带士兵数
 */
@property(nonatomic,strong)NSNumber *maxSoldiers;

/**
 *  武将忠诚度
 */
@property(nonatomic,strong)NSNumber *loyalty;

/**
 *  武将采集力
 */
@property(nonatomic,strong)NSNumber *gatheringCapacity;



/**
 *  初始化方法
 */
-(instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  通过初始化方法实现类的类初始化方法
 */
+(instancetype)generalWithDict:(NSDictionary *)dict;

/**
 *  返回所有武将对象数组
 */
+(NSArray *)allGeneralsList;

@end
