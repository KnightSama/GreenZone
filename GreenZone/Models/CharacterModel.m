//
//  CharacterModel.m
//  Game
//
//  Created by niit on 15-6-30.
//  Copyright (c) 2015年 zw. All rights reserved.
//

#import "CharacterModel.h"

@implementation CharacterModel

/**
 *  角色的初始化方法，通过字典初始化
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
 *  通过调用私有的初始化方法，实现初始化方法，为类方法
 */
+(instancetype)characterWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

/**
 *  返回所有本类的对象数组
 */
+(NSArray *)allCharactersList
{
    NSMutableArray *arrM=[[NSMutableArray alloc]init];
    NSString *path=[[NSBundle mainBundle]pathForResource:@"Character" ofType:@"plist"];
    NSArray *arr=[NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *tmp in arr)
    {
        CharacterModel *model=[CharacterModel characterWithDict:tmp];
        [arrM addObject:model];
    }
    return arrM;
}


/**
 *  归档方法
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.characterId forKey:@"characterId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.icon forKey:@"icon"];
    [aCoder encodeObject:self.smallImage forKey:@"smallImage"];
    [aCoder encodeObject:self.bigImage forKey:@"bigImage"];
    [aCoder encodeObject:self.faceImage forKey:@"faceImage"];
    [aCoder encodeObject:self.animationImage forKey:@"animationImage"];
    [aCoder encodeObject:self.characterDescription forKey:@"characterDescription"];
    [aCoder encodeObject:self.blood forKey:@"blood"];
    [aCoder encodeObject:self.currentBlood forKey:@"currentBlood"];
    [aCoder encodeObject:self.leadAbility forKey:@"leadAbility"];
    [aCoder encodeObject:self.attack forKey:@"attack"];
    [aCoder encodeObject:self.defence forKey:@"defence"];
    [aCoder encodeObject:self.carryingGeneral forKey:@"carryingGeneral"];
    [aCoder encodeObject:self.allGeneral forKey:@"allGeneral"];
    [aCoder encodeObject:self.havingCities forKey:@"havingCities"];
    [aCoder encodeObject:self.soldierNum forKey:@"soldierNum"];
    [aCoder encodeObject:self.equiped forKey:@"equiped"];
    [aCoder encodeObject:self.package forKey:@"package"];
    [aCoder encodeObject:self.tasksList forKey:@"tasksList"];
    [aCoder encodeObject:self.money forKey:@"money"];
    [aCoder encodeObject:self.skillPointRemaining forKey:@"skillPointRemaining"];
    [aCoder encodeObject:self.skillsList forKey:@"skillsList"];
    [aCoder encodeObject:self.power forKey:@"power"];
    [aCoder encodeObject:self.generalNoActing forKey:@"generalNoActing"];
    [aCoder encodeObject:self.soldiersNoActing forKey:@"soldiersNoActing"];
}

/**
 *  解档方法
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.characterId=[aDecoder decodeObjectForKey:@"characterId"];
    self.name=[aDecoder decodeObjectForKey:@"name"];
    self.icon=[aDecoder decodeObjectForKey:@"icon"];
    self.smallImage=[aDecoder decodeObjectForKey:@"smallImage"];
    self.bigImage=[aDecoder decodeObjectForKey:@"bigImage"];
    self.faceImage=[aDecoder decodeObjectForKey:@"faceImage"];
    self.animationImage=[aDecoder decodeObjectForKey:@"animationImage"];
    self.characterDescription=[aDecoder decodeObjectForKey:@"characterDescription"];
    self.blood=[aDecoder decodeObjectForKey:@"blood"];
    self.currentBlood=[aDecoder decodeObjectForKey:@"currentBlood"];
    self.leadAbility=[aDecoder decodeObjectForKey:@"leadAbility"];
    self.attack=[aDecoder decodeObjectForKey:@"attack"];
    self.defence=[aDecoder decodeObjectForKey:@"defence"];
    self.carryingGeneral=[aDecoder decodeObjectForKey:@"carryingGeneral"];
    self.allGeneral=[aDecoder decodeObjectForKey:@"allGeneral"];
    self.havingCities=[aDecoder decodeObjectForKey:@"havingCities"];
    self.soldierNum=[aDecoder decodeObjectForKey:@"soldierNum"];
    self.equiped=[aDecoder decodeObjectForKey:@"equiped"];
    self.package=[aDecoder decodeObjectForKey:@"package"];
    self.tasksList=[aDecoder decodeObjectForKey:@"tasksList"];
    self.money=[aDecoder decodeObjectForKey:@"money"];
    self.skillPointRemaining=[aDecoder decodeObjectForKey:@"skillpointRemaining"];
    self.skillsList=[aDecoder decodeObjectForKey:@"skillsList"];
    self.power=[aDecoder decodeObjectForKey:@"power"];
    self.generalNoActing=[aDecoder decodeObjectForKey:@"generalNoActing"];
    self.soldiersNoActing=[aDecoder decodeObjectForKey:@"soldiersNoActing"];
    return self;
}

@end
