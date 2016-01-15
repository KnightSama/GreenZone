//
//  SystemSetting.h
//  GreenZone
//
//  Created by zqh on 15/6/15.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemSetting : NSObject
/**
 *  是否是第一次打开程序
 */
@property(nonatomic,strong) NSNumber *isFirstOpen;
/**
 *  是否播放声音
 */
@property(nonatomic,strong) NSNumber *isHasSound;

@property(nonatomic,strong) NSDictionary *dict;
+(instancetype)systemSetting;
-(instancetype)initWithDict;
/**
 *   将新的设置保存到plist
 */
-(void)reloadSetting;
@end
