//
//  SaveData.h
//  GreenZone
//
//  Created by student on 15/7/3.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SaveData : NSManagedObject

@property (nonatomic, retain) NSString * sid;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * saveName;
@property (nonatomic, retain) NSString * characterName;
@property (nonatomic, retain) NSNumber * locationX;
@property (nonatomic, retain) NSNumber * locationY;
@property (nonatomic, retain) NSString * characterImage;

@end
