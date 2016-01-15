//
//  Save.m
//  GameModel1
//
//  Created by niit on 15-7-2.
//  Copyright (c) 2015年 zw. All rights reserved.
//

#import "Save.h"
#import "mmDAO.h"
#import "NSManagedObject+helper.h"
#import "SaveData.h"
@implementation Save

/**
 *  归档方法
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.sId forKey:@"sId"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.characterPointX forKey:@"characterPointX"];
    [aCoder encodeObject:self.characterPointY forKey:@"characterPointY"];
    [aCoder encodeObject:self.mapOffSetX forKey:@"mapOffSetX"];
    [aCoder encodeObject:self.mapOffSetY forKey:@"mapOffSetY"];
    [aCoder encodeObject:self.characterModel forKey:@"characterModel"];
    [aCoder encodeObject:self.citiesArr forKey:@"citiesArr"];
    [aCoder encodeObject:self.generalArr forKey:@"generalArr"];
    [aCoder encodeObject:self.mapName forKey:@"mapName"];
    [aCoder encodeObject:self.direction forKey:@"direction"];
}

/**
 *  解档方法
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.sId=[aDecoder decodeObjectForKey:@"sId"];
    self.date=[aDecoder decodeObjectForKey:@"date"];
    self.name=[aDecoder decodeObjectForKey:@"name"];
    self.characterPointX=[aDecoder decodeObjectForKey:@"characterPointX"];
    self.characterPointY=[aDecoder decodeObjectForKey:@"characterPointY"];
    self.mapOffSetX=[aDecoder decodeObjectForKey:@"mapOffSetX"];
    self.mapOffSetY=[aDecoder decodeObjectForKey:@"mapOffSetY"];
    self.characterModel=[aDecoder decodeObjectForKey:@"characterModel"];
    self.citiesArr=[aDecoder decodeObjectForKey:@"citiesArr"];
    self.generalArr=[aDecoder decodeObjectForKey:@"generalArr"];
    self.mapName=[aDecoder decodeObjectForKey:@"mapName"];
    self.direction=[aDecoder decodeObjectForKey:@"direction"];
    return self;
}

/**
 *  保存方法
 */
-(BOOL)saveGame{
    //将存档数据保存到文件
    NSMutableData *data=[NSMutableData data];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:self.name];
    [archiver finishEncoding];
    NSString *fileName = [NSString stringWithFormat:@"%@/Documents/%@.save",NSHomeDirectory(),self.name];
    [data writeToFile:fileName atomically:YES];
    //将存档信息保存到数据库
    SaveData *saveData = [SaveData createNew];
    saveData.sid = [NSString stringWithFormat:@"%@",self.sId];
    saveData.saveName = self.name;
    saveData.time = self.date;
    saveData.characterName = self.characterModel.name;
    saveData.characterImage = self.characterModel.faceImage;
    saveData.locationX = self.characterPointX;
    saveData.locationY = self.characterPointY;
    [SaveData save:^(NSError *error) {
    }];
    return YES;
}

/**
 *  覆盖存档的方法
 */
-(BOOL)saveGameByDeleteSaveId:(NSNumber *)sid{
    //将存档数据保存到文件
    NSMutableData *data=[NSMutableData data];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:self.name];
    [archiver finishEncoding];
    NSString *fileName = [NSString stringWithFormat:@"%@/Documents/%@.save",NSHomeDirectory(),self.name];
    [data writeToFile:fileName atomically:YES];
    //将存档信息保存到数据库
    NSString *pre=[NSString stringWithFormat:@"sid='%@'",sid];
    //将查询条件传给查询方法的第一个参数，查询结果用数组来接收
    NSArray *tmpArr=[SaveData filter:pre orderby:nil offset:0 limit:0];
    SaveData *saveData = tmpArr[0];
    //删除旧文件
    fileName = [NSString stringWithFormat:@"%@/Documents/%@.save",NSHomeDirectory(),saveData.saveName];
    NSFileManager *fm=[NSFileManager defaultManager];
    [fm removeItemAtPath:fileName error:nil];
    //更改存档数据
    saveData.saveName = self.name;
    saveData.time = self.date;
    saveData.characterName = self.characterModel.name;
    saveData.characterImage = self.characterModel.faceImage;
    saveData.locationX = self.characterPointX;
    saveData.locationY = self.characterPointY;
    [SaveData save:^(NSError *error) {
    }];
    return YES;
}

/**
 *  读档方法
 */
+(instancetype)loadGameWithSid:(NSNumber *)sid{
    NSString *pre=[NSString stringWithFormat:@"sid='%@'",sid];
    //将查询条件传给查询方法的第一个参数，查询结果用数组来接收
    NSArray *tmpArr=[SaveData filter:pre orderby:nil offset:0 limit:0];
    SaveData *saveData = tmpArr[0];
     NSString *fileName = [NSString stringWithFormat:@"%@/Documents/%@.save",NSHomeDirectory(),saveData.saveName];
    NSData *data=[NSData dataWithContentsOfFile:fileName];
    NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    Save *save = [unarchiver decodeObjectForKey:saveData.saveName];
    return save;
}

/**
 *  删除存档的方法
 */
-(BOOL)deleteSaveData{
    NSString *fileName = [NSString stringWithFormat:@"%@/Documents/%@.save",NSHomeDirectory(),self.name];
    NSFileManager *fm=[NSFileManager defaultManager];
    [fm removeItemAtPath:fileName error:nil];
    NSString *pre=[NSString stringWithFormat:@"sid='%@'",self.sId];
    //将查询条件传给查询方法的第一个参数，查询结果用数组来接收
    NSArray *tmpArr=[SaveData filter:pre orderby:nil offset:0 limit:0];
    SaveData *saveData = tmpArr[0];
    [SaveData delobject:saveData];
    [SaveData save:^(NSError *error) {
    }];
    return YES;
}

/**
 *  获得数据库中所有存档
 */
+(NSArray *)loadAllGameSave{
    NSMutableArray *tmpArr = [[NSMutableArray alloc]init];
    for (SaveData *saveData in [SaveData filter:nil orderby:nil offset:0 limit:0]) {
        NSString *fileName = [NSString stringWithFormat:@"%@/Documents/%@.save",NSHomeDirectory(),saveData.saveName];
        NSData *data=[NSData dataWithContentsOfFile:fileName];
        NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        Save *save = [unarchiver decodeObjectForKey:saveData.saveName];
        [tmpArr addObject:save];
    }
    return tmpArr;
}

/**
 *  向物品列表添加一个物品
 */
-(void)addThingsWithId:(NSString *)sid withNumber:(NSNumber *)number{
    int having = 0;
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:self.characterModel.package];
    for (NSString *haveId in [self.characterModel.package allKeys]) {
        if ([haveId isEqualToString:sid]) {
            having = 1;
            long oldNum = [[self.characterModel.package valueForKey:haveId] integerValue];
            oldNum = oldNum + [number integerValue];
            [tmpDict setObject:[NSNumber numberWithInteger:oldNum] forKey:haveId];
            self.characterModel.package = tmpDict;
        }
    }
    if (having==0) {
        [tmpDict setObject:number forKey:sid];
        self.characterModel.package = tmpDict;
    }
}
@end
