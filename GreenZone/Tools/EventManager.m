//
//  EventManager.m
//  GreenZone
//
//  Created by student on 15/7/6.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "EventManager.h"
#import "MapViewController.h"
#import "AttackCityBattleViewController.h"
#import <UIKit/UIKit.h>
@implementation EventManager
/**
 *  通过事件编号、存档、视图传入一个事件
 */
-(void)passEventWithNumber:(NSNumber *)number withSave:(Save *)save withViewController:(UIViewController *)controller{
    if ([number intValue]<200) {
        //交给城市事件处理
        CityEventViewController *cityEvent = [[CityEventViewController alloc]initWithView:controller.view WithNumber:number withSave:save];
        cityEvent.delegate = controller;
        [controller presentViewController:cityEvent animated:NO completion:^{
        }];
    }else if ([number intValue]<800) {
        BattleViewController *battleEvent = [[BattleViewController alloc]initWithSave:save andNumber:@704];
        battleEvent.delegate = (MapViewController *)controller;
        [controller presentViewController:battleEvent animated:NO completion:^{
        }];
    }
}

@end
