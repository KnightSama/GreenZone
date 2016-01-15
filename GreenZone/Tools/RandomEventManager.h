//
//  RandomEventManager.h
//  GreenZone
//
//  Created by student on 15/7/8.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Save;
@class UIViewController;

@protocol RandomEventManagerDelegate <NSObject>

-(void)randomEventManagerPassEventMessage:(NSString *)msg;

@end
@interface RandomEventManager : NSObject
@property(nonatomic,weak) id<RandomEventManagerDelegate> delegate;
/**
 *  通过事件编号、存档、视图传入一个事件
 */
-(void)passEventWithNumber:(NSNumber *)number withSave:(Save *)save withViewController:(UIViewController *)controller;
@end
