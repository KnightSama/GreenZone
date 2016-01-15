//
//  Map.m
//  GreenZone
//
//  Created by zqh on 15/7/1.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "Map.h"

@implementation Map

/**
 *  归档方法
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.mapName forKey:@"mapName"];
    [aCoder encodeObject:self.mapPassArr forKey:@"mapPassArr"];
    [aCoder encodeObject:self.mapEventArr forKey:@"mapEventArr"];
}

/**
 *  解档方法
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.mapName=[aDecoder decodeObjectForKey:@"mapName"];
    self.mapPassArr=[aDecoder decodeObjectForKey:@"mapPassArr"];
    self.mapEventArr=[aDecoder decodeObjectForKey:@"mapEventArr"];
    return self;
}

/**
 *  获得一张地图数据
 */
-(instancetype)getMapByName:(NSString *)mapName{
    NSString *fileName = [[NSBundle mainBundle]pathForResource:mapName ofType:@"plist"];
    NSData *data=[NSData dataWithContentsOfFile:fileName];
    NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    Map *map=[unarchiver decodeObjectForKey:mapName];
    return map;
}

@end
