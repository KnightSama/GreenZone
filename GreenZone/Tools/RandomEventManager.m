//
//  RandomEventManager.m
//  GreenZone
//
//  Created by student on 15/7/8.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "RandomEventManager.h"
#import "RandomEventShowViewController.h"
#import "Save.h"
#import "ThingModel.h"
#import "GeneralModel.h"
#import "CityModel.h"
#import "CharacterModel.h"
@implementation RandomEventManager

/**
 *  通过事件编号、存档、视图传入一个事件
 */
-(void)passEventWithNumber:(NSNumber *)number withSave:(Save *)save withViewController:(UIViewController *)controller{
    int eventNum = arc4random_uniform(100);
    NSMutableString *eventMsg = [NSMutableString stringWithString:@""];
    //获得物品
    if (eventNum>10&&eventNum<60) {
        if (arc4random_uniform(10)<6) {
            int money = arc4random_uniform(200)+1;
            save.characterModel.money = [NSNumber numberWithInt:[save.characterModel.money intValue]+money];
            [eventMsg appendFormat:@"在路边发现了钱包,打开后发现有 %i 钱币\n",money];
        }
        if (arc4random_uniform(10)<5){
            NSArray *tmpArr = @[@6018,@6020,@6040,@6050];
            NSNumber *getThing = tmpArr[arc4random_uniform(4)];
             NSArray *thingsList = [ThingModel allThingsList];
            ThingModel *thingModel;
            for (thingModel in thingsList) {
                if ([thingModel.thingId intValue]==[getThing intValue]) {
                    break;
                }
            }
            int number = (arc4random_uniform(3)+1);
            [save addThingsWithId:[NSString stringWithFormat:@"%@",getThing] withNumber:[NSNumber numberWithInt:number]];
            [eventMsg appendFormat:@"发现了 %i 个常见的物品 %@ \n",number,thingModel.name];
        }
        if (arc4random_uniform(10)<2) {
            NSArray *thingsList = [ThingModel allThingsList];
            NSNumber *getThing = [NSNumber numberWithInt:arc4random_uniform(31)];
            ThingModel *thingModel = thingsList[[getThing intValue]];
            [save addThingsWithId:[NSString stringWithFormat:@"%@",thingModel.thingId] withNumber:@1];
            [eventMsg appendFormat:@"人品爆发,额外发现了天降神器 %@ \n",thingModel.name];
        }
    }
    //获得武将
    if (eventNum>=60&&eventNum<70&&save.generalArr.count>0) {
        int getNum = arc4random_uniform((int)save.generalArr.count);
        GeneralModel *getGeneral = save.generalArr[getNum];
        //删除
        NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:save.generalArr];
        [tmpArr removeObject:getGeneral];
        save.generalArr = tmpArr;
        //添加
        tmpArr = [NSMutableArray arrayWithArray:save.characterModel.carryingGeneral];
        [tmpArr addObject:getGeneral];
        save.characterModel.carryingGeneral = tmpArr;
        tmpArr = [NSMutableArray arrayWithArray:save.characterModel.allGeneral];
        [tmpArr addObject:getGeneral];
        save.characterModel.allGeneral = tmpArr;
        if (arc4random_uniform(2)==0) {
            int money = [save.characterModel.money intValue] * ((arc4random_uniform(3)+1)/10.0);
            save.characterModel.money = [NSNumber numberWithInt:[save.characterModel.money intValue] - money];
            [eventMsg appendFormat:@"路遇有人沿路乞讨，你于心不忍给了 %i 钱币,其实他是扫地神僧 %@ ,在他的强力要求下，你让他加入了队伍",money,getGeneral.name];
        }else{
            [eventMsg appendFormat:@"遇到志同道合的小伙伴 %@ ,你们约定要一起征服世界",getGeneral.name];
        }
    }
    //城市叛乱
    if (eventNum>=70&&eventNum<75&&save.characterModel.havingCities.count>0) {
        CityModel *city;
        for (city in save.characterModel.havingCities) {
            if ([city.mana intValue]<50) {
                break;
            }
        }
        if (city) {
            GeneralModel *general;
            for (general in save.characterModel.allGeneral) {
                if ([general.name isEqualToString:city.residenceGeneral]) {
                    break;
                }
            }
            NSMutableArray *tmpArr = [NSMutableArray  arrayWithArray:save.characterModel.allGeneral];
            [tmpArr removeObject:general];
            save.characterModel.allGeneral = tmpArr;
            if (city.residenceGeneral&&![city.residenceGeneral isEqualToString:@""]) {
                city.owner = city.residenceGeneral;
                city.residenceGeneral = @"";
            }else{
                NSArray *allCharacter = [CharacterModel allCharactersList];
                CharacterModel *character = allCharacter[arc4random_uniform((int)allCharacter.count)];
                city.owner = character.name;
            }
            tmpArr = [NSMutableArray  arrayWithArray:save.characterModel.havingCities];
            [tmpArr removeObject:city];
            save.characterModel.havingCities = tmpArr;
            [eventMsg appendFormat:@"你在 %@ 的威望值过低,军民忍无可忍,发动了叛乱,这座城已经不属于你了",city.name];
        }
    }
    //NPC攻城
    if (eventNum>=75&&eventNum<80&&save.characterModel.havingCities.count>0) {
        CityModel *city = save.characterModel.havingCities[arc4random_uniform((int)save.characterModel.havingCities.count)];
        city.residenceSoldiers = [NSNumber numberWithInt:(int)([city.residenceSoldiers intValue]*0.8)];
        city.mana = [NSNumber numberWithInt:(int)([city.mana intValue]*0.9)];
        [eventMsg appendFormat:@"在你不在的时候,有人攻打了你的 %@ ,你在该城市的威望与驻守士兵数都有所下降",city.name];
    }
    //武将叛逃
    if (eventNum>85&&eventNum<90&&save.characterModel.carryingGeneral.count>1) {
        GeneralModel *general;
        for (general in save.characterModel.carryingGeneral) {
            if ([general.loyalty intValue]<50) {
                break;
            }
        }
        NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:save.characterModel.carryingGeneral];
        [tmpArr removeObject:general];
        save.characterModel.carryingGeneral = tmpArr;
        tmpArr = [NSMutableArray arrayWithArray:save.characterModel.allGeneral];
        [tmpArr removeObject:general];
        save.characterModel.allGeneral = tmpArr;
        [eventMsg appendFormat:@"由于你疏远了你的武将 %@ ,他偷偷的逃跑了",general.name];
    }
    if(![eventMsg isEqualToString:@""]){
        //传递事件信息
        [self.delegate randomEventManagerPassEventMessage:eventMsg];
        //弹出窗口显示
        RandomEventShowViewController *random = [[RandomEventShowViewController alloc]initWithMessage:eventMsg withView:controller.view];
        [controller presentViewController:random animated:NO completion:^{
        }];
    }
}
@end
