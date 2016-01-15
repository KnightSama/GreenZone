//
//  packageThingsShowModel.h
//  GreenZone
//
//  Created by student on 15/7/6.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ThingModel.h"


@interface packageThingsShowModel : NSObject

/**
 *  物品
 */
@property(nonatomic,strong)ThingModel *thing;

/**
 *  数量
 */
@property(nonatomic,assign) int thingsCount;

//- (instancetype)initWithDict:(NSDictionary *) dict;
//+ (instancetype)showModelWithDict:(NSDictionary *) dict;
@end
