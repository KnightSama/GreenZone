//
//  Save.h
//  GameModel1
//
//  Created by niit on 15-7-2.
//  Copyright (c) 2015年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CharacterModel.h"


@interface Save : NSObject<NSCoding>


/**
 *  数据ID
 */
@property(nonatomic,strong)NSNumber *sId;

/**
 *  保存时间
 */
@property(nonatomic,strong)NSDate *date;

/**
 *  数据名称
 */
@property(nonatomic,strong)NSString *name;

/**
 *  地图名字
 */
@property(nonatomic,strong)NSString *mapName;

/**
 *  人物横坐标
 */
@property(nonatomic,strong)NSNumber *characterPointX;

/** 
 *  人物纵坐标
 */
@property(nonatomic,strong)NSNumber *characterPointY;

/**
 *  地图横向位移
 */
@property(nonatomic,strong)NSNumber *mapOffSetX;

/**
 *  地图纵向位移
 */
@property(nonatomic,strong)NSNumber *mapOffSetY;

/**
 *  人物方向 @0向下  @1向左  @2向右   @3向上
 */
@property(nonatomic,strong)NSNumber *direction;

/**
 *  人物对象
 */
@property(nonatomic,strong)CharacterModel *characterModel;

/**
 *  城市数组
 */
@property(nonatomic,strong)NSMutableArray *citiesArr;

/**
 *  剩余武将数组
 */
@property(nonatomic,strong)NSMutableArray *generalArr;

/**
 *  归档方法
 */
-(void)encodeWithCoder:(NSCoder *)aCoder;

/**
 *  解档方法
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder;

/**
 *  保存方法
 */
-(BOOL)saveGame;

/**
 *  覆盖存档的方法
 */
-(BOOL)saveGameByDeleteSaveId:(NSNumber *)sid;

/**
 *  删除存档的方法
 */
-(BOOL)deleteSaveData;

/**
 *  读档方法
 */
+(instancetype)loadGameWithSid:(NSNumber *)sid;

/**
 *  获得数据库中所有存档
 */
+(NSArray *)loadAllGameSave;
/**
 *  向物品列表添加一个物品
 */
-(void)addThingsWithId:(NSString *)sid withNumber:(NSNumber *)number;
@end
