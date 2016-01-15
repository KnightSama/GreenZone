//
//  FirstOpenViewController.h
//  GreenZone
//
//  Created by zqh on 15/6/15.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AVAudioPlayer;
@interface FirstOpenViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *showView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageView;
@property(nonatomic,strong) AVAudioPlayer *player;
@end
