//
//  HelpViewController.h
//  GreenZone
//
//  Created by niit on 15-7-6.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AVAudioPlayer;
@interface HelpViewController : UIViewController
@property(nonatomic,strong) AVAudioPlayer *player;
///**
// *  seg的选中位置
// */
//@property(nonatomic,assign)NSInteger index;

/**
 *  帮助信息
 */
@property(nonatomic,strong)NSArray *infoList;

/**
 *  帮助信息显示区域
 */
@property(nonatomic,strong)UITextView *textView;

@end
