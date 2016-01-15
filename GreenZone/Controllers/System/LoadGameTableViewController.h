//
//  LoadGameTableViewController.h
//  GreenZone
//
//  Created by zqh on 15/7/3.
//  Copyright (c) 2015年 student. All rights reserved.
//
#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0  //屏幕适配，自动计算不同屏幕对应的x和y方向的坐标
#define H(y) WinHeight*y/568.0
#import <UIKit/UIKit.h>
@class AVAudioPlayer;
@interface LoadGameTableViewController : UITableViewController
@property(nonatomic,strong) AVAudioPlayer *player;
/**
 *  tableView的数据源数组
 */
@property(nonatomic,strong) NSMutableArray *saveList;
/**
 *  要删除的行
 */
@property(nonatomic,strong) NSIndexPath *indexPath;
/**
 *  选中的行数
 */
@property(nonatomic,assign) long location;
/**
 *  返回方式 @0模态返回  @1导航返回
 */
@property(nonatomic,strong) NSNumber *backStyle;

/**
 *  通过返回方式创建 @0模态返回  @1导航返回
 */
-(instancetype)initWithBackStyle:(NSNumber *)number;
@end
