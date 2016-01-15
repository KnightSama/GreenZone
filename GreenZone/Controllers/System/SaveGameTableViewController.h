//
//  SaveGameTableViewController.h
//  GreenZone
//
//  Created by zqh on 15/7/5.
//  Copyright (c) 2015年 student. All rights reserved.
//

#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0  //屏幕适配，自动计算不同屏幕对应的x和y方向的坐标
#define H(y) WinHeight*y/568.0
#import <UIKit/UIKit.h>
@class AVAudioPlayer;
@class Save;
@interface SaveGameTableViewController : UITableViewController
@property(nonatomic,strong) AVAudioPlayer *player;
/**
 *  所有的存档数据
 */
@property(nonatomic,strong) NSMutableArray *saveList;
/**
 *  要保存的存档
 */
@property(nonatomic,strong) Save *save;
/**
 *  要覆盖存档的位置
 */
@property(nonatomic,assign) long location;

/**
 *  通过新的存档创建
 */
-(instancetype)initWithSave:(Save *)save;
@end
