//
//  CardModel.h
//  Game
//
//  Created by niit on 15-6-30.
//  Copyright (c) 2015年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardModel : NSObject<NSCoding>


/**
 *  卡片Id
 */
@property(nonatomic,strong)NSString *cardId;

/**
 *  卡片名称
 */
@property(nonatomic,strong)NSString *name;

/**
 *  卡片图标名字
 */
@property(nonatomic,strong)NSString *icon;

/**
 *  卡片图片名字
 */
@property(nonatomic,strong)NSString *image;

/**
 *  卡片介绍
 */
@property(nonatomic,strong)NSString *cardDescription;

/**
 *  卡片事件Id
 */
@property(nonatomic,strong)NSString *eventId;

/**
 *  卡片价格
 */
@property(nonatomic,strong)NSNumber *price;

/**
 *  本类的初始化方法
 */
-(instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  本类的类初始化方法
 */
+(instancetype)cardWithDict:(NSDictionary *)dict;

/**
 *  返回所有卡片对象数组
 */
+(NSArray *)allCardsList;



@end
