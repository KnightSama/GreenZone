//
//  GameFunction.h
//  GreenZone
//
//  Created by zqh on 15/7/3.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharacterModel.h"
#import "CityModel.h"
#import "GeneralModel.h"
#import "Save.h"


@interface GameFunction : NSObject

/**
 *  角色信息
 */
@property(nonatomic,strong) CharacterModel *character;
/**
 *  城市列表
 */
@property(nonatomic,strong) NSMutableArray *cityArray;
/**
 *  武将信息
 */
@property(nonatomic,strong) NSMutableArray *generalArray;
/**
 *  存档信息
 */
@property(nonatomic,strong) Save *save;


/**
 *  通过角色信息创建一个新游戏
 */
-(void)startNewGameByCharacter:(CharacterModel *)character;
/**
 *  通过存档信息开始一个游戏
 */
-(void)startGameBySaveData:(Save *)save;
@end
