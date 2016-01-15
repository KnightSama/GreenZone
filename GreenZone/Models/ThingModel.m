//
//  ThingModel.m
//  Game
//
//  Created by niit on 15-6-30.
//  Copyright (c) 2015年 zw. All rights reserved.
//

#import "ThingModel.h"

@implementation ThingModel



/**
 *  本类的初始化方法
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
 *  本类的类初始化方法
 */
+(instancetype)thingWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

/**
 *  返回所有物品对象数组
 */
+(NSArray *)allThingsList
{
    NSString *path=[[NSBundle mainBundle]pathForResource:@"Thing" ofType:@"plist"];
    NSMutableArray *arrM=[[NSMutableArray alloc]init];
    NSArray *arr=[NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *tmp in arr)
    {
        ThingModel *model=[ThingModel thingWithDict:tmp];
        [arrM addObject:model];
    }
    return arrM;
}


@end
