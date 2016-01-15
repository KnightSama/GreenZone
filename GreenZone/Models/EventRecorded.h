//
//  EventRecorded.h
//  GreenZone
//
//  Created by niit on 15-7-7.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventRecorded : NSObject

/**
 *  所有事件保存列表（只保留前50）
 */
@property(nonatomic,strong)NSMutableDictionary *eventsDict;
@property(nonatomic,strong)NSMutableArray *keysArr;



/**
 *  接受事件
 */
-(void)acceptEvent:(NSString *)event;

@end
