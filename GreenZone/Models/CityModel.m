//
//  CityModel.m
//  City
//
//  Created by niit on 15-6-29.
//  Copyright (c) 2015年 zw. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

/**
 *  根据字典初始化对象
 */
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

/**
 *  根据本类的初始化方法返回对象 本方法为类方法
 */
+(instancetype)cityWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

/**
 *  返回所有城市数组
 */
+(NSArray *)allCitiesList
{
    NSMutableArray *arrM=[[NSMutableArray alloc]init];
    
    //从plist中读取数据
    NSString *path=[[NSBundle mainBundle]pathForResource:@"City" ofType:@"plist"];
    NSArray *arr=[NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *tmp in arr)
    {
        CityModel *model=[CityModel cityWithDict:tmp];
        [arrM addObject:model];
    }
    return arrM;
}


/**
 *  归档方法
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.cityId forKey:@"cityId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.icon forKey:@"icon"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.cityDescription forKey:@"cityDescription"];
    [aCoder encodeObject:self.attack forKey:@"attack"];
    [aCoder encodeObject:self.defence forKey:@"defence"];
    [aCoder encodeObject:self.owner forKey:@"owner"];
    [aCoder encodeObject:self.tasksList forKey:@"tasksList"];
    [aCoder encodeObject:self.eventsList forKey:@"eventsList"];
    [aCoder encodeObject:self.mana forKey:@"mana"];
    [aCoder encodeObject:self.roadToll forKey:@"roadToll"];
    [aCoder encodeObject:self.output forKey:@"output"];
    [aCoder encodeObject:self.residenceGeneral forKey:@"residenceGeneral"];
    [aCoder encodeObject:self.residenceSoldiers forKey:@"residenceSoldiers"];
}

/**
 *  解档方法
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.cityId=[aDecoder decodeObjectForKey:@"cityId"];
    self.name=[aDecoder decodeObjectForKey:@"name"];
    self.icon=[aDecoder decodeObjectForKey:@"icon"];
    self.image=[aDecoder decodeObjectForKey:@"image"];
    self.cityDescription=[aDecoder decodeObjectForKey:@"cityDescription"];
    self.attack=[aDecoder decodeObjectForKey:@"attack"];
    self.defence=[aDecoder decodeObjectForKey:@"defence"];
    self.owner=[aDecoder decodeObjectForKey:@"owner"];
    self.tasksList=[aDecoder decodeObjectForKey:@"tasksList"];
    self.eventsList=[aDecoder decodeObjectForKey:@"eventsList"];
    self.mana=[aDecoder decodeObjectForKey:@"mana"];
    self.roadToll=[aDecoder decodeObjectForKey:@"roadToll"];
    self.output=[aDecoder decodeObjectForKey:@"output"];
    self.residenceGeneral=[aDecoder decodeObjectForKey:@"residenceGeneral"];
    self.residenceSoldiers=[aDecoder decodeObjectForKey:@"residenceSoldiers"];
    return self;
}



@end
