//
//  EventTableViewController.h
//  GreenZone
//
//  Created by niit on 15-7-7.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EventRecorded;
@class AVAudioPlayer;
@interface EventTableViewController : UITableViewController
@property(nonatomic,strong) AVAudioPlayer *player;
/**
 *  事件记录
 */
@property(nonatomic,strong)EventRecorded *eventsRecord;

/**
 *  字典中所有事件的时间keys
 */
@property(nonatomic,strong)NSArray *keysArr;

/**
 *  所有时间
 */
@property(nonatomic,strong)NSDictionary *evenstDict;


/**
 *   通过事件表初始化
 */
-(instancetype)initWithEventsList:(EventRecorded *)eventsRecord;

@end
