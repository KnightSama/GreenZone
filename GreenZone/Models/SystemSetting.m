//
//  SystemSetting.m
//  GreenZone
//
//  Created by zqh on 15/6/15.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "SystemSetting.h"

@implementation SystemSetting

-(NSDictionary *)dict{
    if (!_dict) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"systemSetting.plist" ofType:nil];
        _dict = [[NSDictionary alloc]initWithContentsOfFile:path];
    }
    return _dict;
}

+(instancetype)systemSetting{
    return [[[self class]alloc]initWithDict];
}

-(instancetype)initWithDict{
    if (self = [super init]) {
       [self setValuesForKeysWithDictionary:self.dict];
    }
    return self;
}

-(void)reloadSetting{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:self.dict];
    /**
     *  更改数据
     */
    [dict setObject:self.isFirstOpen forKey:@"isFirstOpen"];
    [dict setObject:self.isHasSound forKey:@"isHasSound"];
    /**
     *  保存数据
     */
    NSString *path = [[NSBundle mainBundle]pathForResource:@"systemSetting.plist" ofType:nil];
    [dict writeToFile:path atomically:YES];
}

@end
