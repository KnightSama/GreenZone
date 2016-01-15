//
//  ThingModel.h
//  Game
//
//  Created by niit on 15-6-30.
//  Copyright (c) 2015年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThingModel : NSObject

/**
 *  物品Id
 */
@property(nonatomic,strong)NSString *thingId;

/**
 *   物品名称
 */
@property(nonatomic,strong)NSString *name;

/**
 *  物品图标名字
 */
@property(nonatomic,strong)NSString *icon;

/**
 *  物品图片名字
 */
@property(nonatomic,strong)NSString *image;

/**
 *  物品介绍
 */
@property(nonatomic,strong)NSString *thingDescription;

/**
 *  物品事件Id
 */
@property(nonatomic,strong)NSString *eventId;

/**
 *  物品价格
 */
@property(nonatomic,strong)NSNumber *price;

/**
 *  本类的初始化方法
 */
-(instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  本类的类初始化方法
 */
+(instancetype)thingWithDict:(NSDictionary *)dict;

/**
 *  返回所有物品对象数组
 */
+(NSArray *)allThingsList;

@end
