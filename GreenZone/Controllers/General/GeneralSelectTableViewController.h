//
//  GeneralSelectTableViewController.h
//  GreenZone
//
//  Created by student on 15-7-6.
//  Copyright (c) 2015年 student. All rights reserved.
//
#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0  //屏幕适配，自动计算不同屏幕对应的x和y方向的坐标
#define H(y) WinHeight*y/568.0
#import <UIKit/UIKit.h>
@class Save;
@interface GeneralSelectTableViewController : UITableViewController
/**
 *  存档信息
 */
@property(nonatomic,strong) Save *save;

/**
 *  武将行动值
 */
@property(nonatomic,strong) NSNumber *number;

/**
 *  通过存档和武将行动值初始化
 */
-(instancetype)initWithSave:(Save *)save andNumber:(NSNumber *)number;
@end
