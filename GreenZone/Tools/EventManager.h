//
//  EventManager.h
//  GreenZone
//
//  Created by student on 15/7/6.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BattleViewController.h"
#import "CityEventViewController.h"
@class Save;
@class UIViewController;
@interface EventManager : NSObject
/**
 *  传入的控制器
 */
@property(nonatomic,strong) UIViewController *controller;
/**
 *  通过事件编号、存档、视图传入一个事件
 */
-(void)passEventWithNumber:(NSNumber *)number withSave:(Save *)save withViewController:(UIViewController *)controller;

@end
