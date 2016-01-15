//
//  Map.h
//  GreenZone
//
//  Created by zqh on 15/7/1.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Map : NSObject<NSCoding>
/**
 *  地图图片的名字
 */
@property(nonatomic,strong) NSString *mapName;
/**
 *  地图的通行数组
 */
@property(nonatomic,strong) NSArray *mapPassArr;
/**
 *  地图的事件数组
 */
@property(nonatomic,strong) NSArray *mapEventArr;


/**
 *  获得一张地图数据
 */
-(instancetype)getMapByName:(NSString *)mapName;
@end
