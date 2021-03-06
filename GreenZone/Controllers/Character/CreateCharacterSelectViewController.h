//
//  CreateCharacterSelectViewController.h
//  GreenZone
//
//  Created by zqh on 15/7/1.
//  Copyright (c) 2015年 student. All rights reserved.
//


#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0  //屏幕适配，自动计算不同屏幕对应的x和y方向的坐标
#define H(y) WinHeight*y/568.0

#define CellHeight 116

#import <UIKit/UIKit.h>
@class AVAudioPlayer;

@interface CreateCharacterSelectViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong) AVAudioPlayer *player;
/**
 *  角色数据列表
 */
@property(nonatomic,strong) NSArray *CharacterArray;

/**
 *  返回到开始界面
 */
- (IBAction)gotoStartViewController:(id)sender;

@end
