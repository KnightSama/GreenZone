//
//  faceDetailModel.m
//  GreenZone
//
//  Created by student on 15/7/3.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "faceDetailModel.h"

@implementation faceDetailModel



- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[[self class]alloc]initWithDict:dict];
}

@end
