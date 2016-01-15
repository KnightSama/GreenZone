//
//  EventRecorded.m
//  GreenZone
//
//  Created by niit on 15-7-7.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "EventRecorded.h"

@implementation EventRecorded


/**
 *  延迟实例化
 */
-(NSMutableDictionary *)eventsDict
{
    if (!_eventsDict)
    {
        _eventsDict = [[NSMutableDictionary alloc]init];
    }
    return _eventsDict;
}

-(NSMutableArray *)keysArr
{
    if (!_keysArr)
    {
        _keysArr = [[NSMutableArray alloc]init];
    }
    return _keysArr;
}

/**
 *  接受事件
 */
-(void)acceptEvent:(NSString *)event
{
    NSDate *now = [NSDate date];
    
    
    //将key按照时间字符串存进数组
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *str = [formatter stringFromDate:now];
    [self.eventsDict setObject:event forKey:str];
    [self.keysArr addObject:str];
    if (self.keysArr.count == 51)
    {
        [self.keysArr removeObjectAtIndex:0];
    }
}




@end
