//
//  MonsterModel.m
//  Game
//
//  Created by niit on 15-6-30.
//  Copyright (c) 2015年 zw. All rights reserved.
//

#import "MonsterModel.h"

@implementation MonsterModel


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
+(instancetype)monsterWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

/**
 *  返回所有怪物对象数组
 */
+(NSArray *)allMonstersList
{
    NSString *path=[[NSBundle mainBundle]pathForResource:@"Monster" ofType:@"plist"];
    NSMutableArray *arrM=[[NSMutableArray alloc]init];
    NSArray *arr=[NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *tmp in arr)
    {
        MonsterModel *model=[MonsterModel monsterWithDict:tmp];
        [arrM addObject:model];
    }
    return arrM;
}

@end
