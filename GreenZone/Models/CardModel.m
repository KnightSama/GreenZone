//
//  CardModel.m
//  Game
//
//  Created by niit on 15-6-30.
//  Copyright (c) 2015年 zw. All rights reserved.
//

#import "CardModel.h"

@implementation CardModel


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
+(instancetype)cardWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

/**
 *  返回所有卡片对象数组
 */
+(NSArray *)allCardsList
{
    NSString *path=[[NSBundle mainBundle]pathForResource:@"Card" ofType:@"plist"];
    NSMutableArray *arrM=[[NSMutableArray alloc]init];
    NSArray *arr=[NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *tmp in arr)
    {
        CardModel *model=[CardModel cardWithDict:tmp];
        [arrM addObject:model];
    }
    return arrM;
}

@end
