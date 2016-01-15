//
//  AppDelegate.h
//  GreenZone
//
//  Created by zqh on 15/6/15.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Save;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  跳转到初始的视图
 */
-(void)gotoStartView;
/**
 *  跳转到创建角色视图
 */
-(void)gotoCreateCharacterView;
/**
 *  跳转到游戏开始地图界面
 */
-(void)gameStartWithSave:(Save *)save;
/**
 *  跳转到捏脸视图
 */
-(void)gotoMakeFace;
@end

