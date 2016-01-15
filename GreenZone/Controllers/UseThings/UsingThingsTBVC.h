//
//  UsingThingsTBVC.h
//  GreenZone
//
//  Created by student on 15/7/7.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Save.h"
@class AVAudioPlayer;
@interface UsingThingsTBVC : UITableViewController

/**
 *  音乐
 */
@property(nonatomic,strong) AVAudioPlayer *player;

- (void)usingThingWithSavedata:(Save *)save;

@end
