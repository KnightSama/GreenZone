//
//  AppDelegate.m
//  GreenZone
//
//  Created by zqh on 15/6/15.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "AppDelegate.h"
#import "SystemSetting.h"
#import "FirstOpenViewController.h"
#import "StartViewController.h"
#import "CreateCharacterController.h"
#import "mmDAO.h"
#import "Save.h"
#import "MapViewController.h"
#import "faceMake.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@",NSHomeDirectory());
    //初始化数据库
    [[mmDAO instance]setupEnvModel:@"GameData" DbFile:@"gameData.sqlite"];
    //初始化程序视图
     self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //加载用户设置
    SystemSetting *setting = [SystemSetting systemSetting];
    //根据设置跳转页面
    if (setting.isFirstOpen.intValue ==1) {
        self.window.rootViewController = [[FirstOpenViewController alloc]init];
        setting.isFirstOpen = @0;
        [setting reloadSetting];
    }else{
        [self gotoStartView];
        //[self gotoTestView];
    }
    return YES;
}

/**
 *  跳转到初始的视图
 */
-(void)gotoStartView{
    StartViewController *svc = [[StartViewController alloc]init];
    self.window.rootViewController = svc;
}

/**
 *  跳转到创建角色视图
 */
-(void)gotoCreateCharacterView{
    CreateCharacterController *createController = [[UIStoryboard storyboardWithName:@"CreateCharacter" bundle:nil]instantiateViewControllerWithIdentifier:@"createCharacter"];
    self.window.rootViewController = createController;
}

/**
 *  跳转到游戏开始地图界面
 */
-(void)gameStartWithSave:(Save *)save{
    MapViewController *mapController = [[MapViewController alloc]initWithSave:save];
    self.window.rootViewController = mapController;
}

/**
 *  跳转到捏脸视图
 */
-(void)gotoMakeFace{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"faceMake" bundle:[NSBundle mainBundle]];
    faceMake *faceVC = [storyBoard instantiateViewControllerWithIdentifier:@"face"];
    self.window.rootViewController = faceVC;
}

/**
 *  跳转到测试用视图
 */
-(void)gotoTestView{
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MapTest" bundle:nil];
    //TestViewController *mapView = [storyboard instantiateViewControllerWithIdentifier:@"makeMap"];
    //self.window.rootViewController = vc;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
