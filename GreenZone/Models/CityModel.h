//
//  CityModel.h
//  City
//
//  Created by niit on 15-6-29.
//  Copyright (c) 2015年 zw. All rights reserved.
//


/**
 *  本类是城市类，包含城市的各种属性
 */



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




@interface CityModel : NSObject

/**
 *  城市ID
 */
@property(nonatomic,strong)NSString *cityId;

/**
 *  城市名字
 */
@property(nonatomic,strong)NSString *name;

/**
 *  城市图标（小图）的图片名
 */
@property(nonatomic,strong)NSString *icon;

/**
 *  城市图像(大图)的图片名
 */
@property(nonatomic,strong)NSString *image;

/**
 *  城市介绍
 */
@property(nonatomic,strong)NSString *cityDescription;

/**
 *  城市的攻击力
 */
@property(nonatomic,strong)NSNumber *attack;

/**
 *  城市防御力
 */
@property(nonatomic,strong)NSNumber *defence;

/**
 *  城市的拥有者
 */
@property(nonatomic,strong)NSString *owner;

/**
 *  城市的任务列表
 */
@property(nonatomic,strong)NSMutableArray *tasksList;

/**
 *  城市的事件列表（未发布的任务)
 */
@property(nonatomic,strong)NSMutableArray *eventsList;

/**
 *  主角在该城市的威望
 */
@property(nonatomic,strong)NSNumber *mana;

/**
 *  城市的过路费
 */
@property(nonatomic,strong)NSNumber *roadToll;

/**
 *  城市的产值（包括初始时间和总值）
 */
@property(nonatomic,strong)NSMutableDictionary *output;

/**
 *  城市的驻守将领
 */
@property(nonatomic,strong)NSString *residenceGeneral;

/**
 *  城市的驻守士兵数
 */
@property(nonatomic,strong)NSNumber *residenceSoldiers;


/**
 *  根据字典初始化对象
 */
-(instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  根据本类的初始化方法返回对象 本方法为类方法
 */
+(instancetype)cityWithDict:(NSDictionary *)dict;

/**
 *  返回所有城市数组
 */
+(NSArray *)allCitiesList;

/**
 *  归档方法
 */
-(void)encodeWithCoder:(NSCoder *)aCoder;

/**
 *  解档方法
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder;


@end
