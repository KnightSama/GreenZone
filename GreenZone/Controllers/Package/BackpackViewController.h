//
//  BackpackViewController.h
//  backpack
//
//  Created by student on 15/7/6.
//  Copyright (c) 2015年 youki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Save.h"
@class AVAudioPlayer;
@interface BackpackViewController : UIViewController


/**
 *  存档数据
 */
@property(nonatomic,strong) Save *saveData;

/**
 *  音乐
 */
@property(nonatomic,strong)  AVAudioPlayer *player;

/**
 *  由存档方法来获得背包列表
 */
- (void)packageWithSavedata:(Save *)save;

@end
