//
//  GameFunction.m
//  GreenZone
//
//  Created by zqh on 15/7/3.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "GameFunction.h"
#import "AppDelegate.h"

@implementation GameFunction

/**
 *  通过角色信息创建一个新游戏
 */
-(void)startNewGameByCharacter:(CharacterModel *)character{
    self.save = [[Save alloc]init];
    //初始化人物数据
    self.save.characterModel = character;
    self.save.characterModel.money = @1000;
    self.save.characterPointX = @224;
    self.save.characterPointY = @992;
    self.save.mapOffSetX = @64;
    self.save.mapOffSetY = @704;
    self.save.mapName = @"map001";
    self.save.direction = @0;
    //初始化城市与武将
    [self createCityWithGeneral];
    UIApplication *application = [UIApplication sharedApplication];
    AppDelegate *delegate = application.delegate;
    [delegate gameStartWithSave:self.save];
}

/**
 *  通过存档信息开始一个游戏
 */
-(void)startGameBySaveData:(Save *)save{
    UIApplication *application = [UIApplication sharedApplication];
    AppDelegate *delegate = application.delegate;
    [delegate gameStartWithSave:save];
}

/**
 *  初始化城市与武将
 */
-(void)createCityWithGeneral{
    self.cityArray = [NSMutableArray arrayWithArray:[CityModel allCitiesList]];
    self.generalArray = [NSMutableArray arrayWithArray:[GeneralModel allGeneralsList]];
    //为玩家分配初始城市
    self.save.characterModel.havingCities  = [NSMutableArray arrayWithObject:self.cityArray[0]];
    CityModel *city = self.save.characterModel.havingCities[0];
    city.owner = self.save.characterModel.name;
    [self.cityArray removeObjectAtIndex:0];
    //为玩家分配初始武将
    self.save.characterModel.allGeneral = [NSMutableArray arrayWithObject:self.generalArray[0]];
    self.save.characterModel.carryingGeneral = [NSMutableArray arrayWithObject:self.generalArray[0]];
    [self.generalArray removeObjectAtIndex:0];
    //为其余城市随机分配武将
    for (CityModel *city in self.cityArray) {
        int mark = arc4random_uniform((int)self.generalArray.count);
        GeneralModel *general = self.generalArray[mark];
        city.residenceGeneral = general.generalId;
        [self.generalArray removeObject:general];
    }
    self.save.citiesArr = self.cityArray;
    self.save.generalArr = self.generalArray;
}
@end
