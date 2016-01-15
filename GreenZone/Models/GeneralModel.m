//
//  GeneralModel.m
//  Game
//
//  Created by niit on 15-6-30.
//  Copyright (c) 2015年 zw. All rights reserved.
//

#import "GeneralModel.h"

@implementation GeneralModel

/**
 *  初始化方法
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
 *  通过初始化方法实现类的类初始化方法
 */
+(instancetype)generalWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

/**
 *  返回所有武将对象数组
 */
+(NSArray *)allGeneralsList
{
    NSString *path=[[NSBundle mainBundle]pathForResource:@"General" ofType:@"plist"];
    NSMutableArray *arrM=[[NSMutableArray alloc]init];
    NSArray *arr=[NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *tmp in arr)
    {
        GeneralModel *model=[GeneralModel generalWithDict:tmp];
        [arrM addObject:model];
    }
    return arrM;
}

/**
 *  解档方法
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.generalId = [aDecoder decodeObjectForKey:@"generalId"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.icon = [aDecoder decodeObjectForKey:@"icon"];
    self.image = [aDecoder decodeObjectForKey:@"image"];
    self.generalDescription = [aDecoder decodeObjectForKey:@"generalDescription"];
    self.attack = [aDecoder decodeObjectForKey:@"attack"];
    self.defence = [aDecoder decodeObjectForKey:@"defence"];
    self.power = [aDecoder decodeObjectForKey:@"power"];
    self.maxSoldiers = [aDecoder decodeObjectForKey:@"maxSoldiers"];
    self.loyalty = [aDecoder decodeObjectForKey:@"loyalty"];
    self.gatheringCapacity = [aDecoder decodeObjectForKey:@"gatheringCapacity"];
    return self;
}

/**
 *  归档方法
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.generalId forKey:@"generalId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.icon forKey:@"icon"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.generalDescription forKey:@"generalDescription"];
    [aCoder encodeObject:self.attack forKey:@"attack"];
    [aCoder encodeObject:self.defence forKey:@"defence"];
    [aCoder encodeObject:self.power forKey:@"power"];
    [aCoder encodeObject:self.maxSoldiers forKey:@"maxSoldiers"];
    [aCoder encodeObject:self.loyalty forKey:@"loyalty"];
    [aCoder encodeObject:self.gatheringCapacity forKey:@"gatheringCapacity"];
}

@end
