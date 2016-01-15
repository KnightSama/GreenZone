//
//  BattleViewController.m
//  GreenZone
//
//  Created by student on 15-7-7.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "BattleViewController.h"
#import "Save.h"
#import "ImageClip.h"
#import "MonsterModel.h"
#import "ThingModel.h"
#import "AudioTool.h"

@interface BattleViewController ()

@end

@implementation BattleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.BOSS = [[NSMutableArray alloc]init];
    self.smallMonsters = [[NSMutableArray alloc]init];
    self.monsters = [MonsterModel allMonstersList];
    for (MonsterModel *tmp in self.monsters) {
        if ([tmp.monsterId integerValue]>712&&[tmp.monsterId integerValue]<722) {
            [self.BOSS addObject:tmp];
        }
        else{
            [self.smallMonsters addObject:tmp];
        }
    }
    [self createWindowUI];
}

-(void)viewWillAppear:(BOOL)animated{
    self.player  = [AudioTool playMusic:@"attackMonster.mp3"];
    self.player.numberOfLoops = NSNotFound;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player stop];
}


/**
 *   根据存档初始化
 */
-(instancetype)initWithSave:(Save *)save andNumber:(NSNumber *)number
{
    if (self = [super init])
    {
        self.save = save;
        self.number = number;
    }
    return self;
}

/**
 *  创建界面
 */
-(void)createWindowUI{
    MonsterModel *amonster = [[MonsterModel alloc]init];
    if ([self.number integerValue]>712&&[self.number integerValue]<722) {
        amonster = self.BOSS[[self.number integerValue]-713];
    }
    else{
        int randnum = arc4random()%30;
        amonster = self.smallMonsters[randnum];
    }
    self.currentMonster = amonster;
    //创建背景
    //刷地面背景
    UIImageView *backView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WinWidth, H(294))];
    backView1.image = [ImageClip imageWithPngName:@"BattleBG1"];
    [self.view addSubview:backView1];
    //刷天空背景
    UIImageView *backView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WinWidth, H(294))];
    backView2.image = [ImageClip imageWithPngName:@"BattleBG2"];
    [self.view addSubview:backView2];
    
    //刷怪物脸图
    UIImageView *monsterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W(127), H(102), W(178), H(128))];
    monsterImageView.image = [ImageClip imageWithPngName:amonster.image];
    [backView2 addSubview:monsterImageView];
    //刷玩家行走图脸朝右
    UIImageView *playerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W(19), H(197), W(32), H(32))];
    playerImageView.image = [ImageClip imageWithCharacterImage:self.save.characterModel.animationImage getByDirectionNumber:@2];
    [backView2 addSubview:playerImageView];
    
    //刷下方详细情况
    UIImageView *backView3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, H(294), W(320), H(274))];
    backView3.backgroundColor = [UIColor whiteColor];
    backView3.userInteractionEnabled = YES;
    [self.view addSubview:backView3];
    //怪物名字
    UILabel *monsterNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(8), H(8), W(76), H(38))];
    monsterNameLabel.layer.borderWidth = 1.0;
    monsterNameLabel.text = amonster.name;
    monsterNameLabel.textAlignment = NSTextAlignmentCenter;
    [backView3 addSubview:monsterNameLabel];
    //怪物攻击
    UILabel *monsterAtkLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(122), H(8), W(76), H(38))];
    monsterAtkLabel.layer.borderWidth = 1.0;
    monsterAtkLabel.text = [NSString stringWithFormat:@"攻击力:%@",amonster.attack];
    monsterAtkLabel.textAlignment = NSTextAlignmentCenter;
    [backView3 addSubview:monsterAtkLabel];
    //怪物防御
    UILabel *monsterDefLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(236), H(8), W(76), H(38))];
    monsterDefLabel.layer.borderWidth = 1.0;
    monsterDefLabel.text = [NSString stringWithFormat:@"防御力:%@",amonster.defence];
    monsterDefLabel.textAlignment = NSTextAlignmentCenter;
    [backView3 addSubview:monsterDefLabel];
    //怪物当前血量
    UILabel *monsterCurrentBloodLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(8), H(54), W(76), H(38))];
    monsterCurrentBloodLabel.layer.borderWidth = 1.0;
    monsterCurrentBloodLabel.text = [NSString stringWithFormat:@"血量:%@",amonster.currentBlood];
    monsterCurrentBloodLabel.textAlignment = NSTextAlignmentCenter;
    [backView3 addSubview:monsterCurrentBloodLabel];
    //怪物描述
    UITextView *monsterDescriptionTextView = [[UITextView alloc]initWithFrame:CGRectMake(W(122), H(54), W(190), H(38))];
    monsterDescriptionTextView.text = amonster.monsterDescription;
    monsterDescriptionTextView.editable = NO;
    monsterDescriptionTextView.layer.borderWidth = 1.0;
    [backView3 addSubview:monsterDescriptionTextView];
    //主角头像
    UIImageView *playerFaceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W(8), H(121), W(96), H(96))];
    playerFaceImageView.image = [ImageClip imageWithFaceImage:self.save.characterModel.faceImage getByLocation:@0];
    playerFaceImageView.layer.borderWidth = 1.0;
    [backView3 addSubview:playerFaceImageView];
    //主角血量
    UILabel *playerBloodLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(127), H(121), W(76), H(38))];
    playerBloodLabel.layer.borderWidth = 1.0;
    playerBloodLabel.text = [NSString stringWithFormat:@"血量:%@",self.save.characterModel.currentBlood];
    playerBloodLabel.textAlignment = NSTextAlignmentCenter;
    [backView3 addSubview:playerBloodLabel];
    //主角兵力
    UILabel *playerSoliderLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(222), H(121), W(76), H(38))];
    playerSoliderLabel.layer.borderWidth = 1.0;
    playerSoliderLabel.text = [NSString stringWithFormat:@"兵力:%@",self.save.characterModel.soldierNum];
    playerSoliderLabel.textAlignment = NSTextAlignmentCenter;
    [backView3 addSubview:playerSoliderLabel];
    
    //主角攻击
    UILabel *playerAtkLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(127), H(179), W(76), H(38))];
    playerAtkLabel.layer.borderWidth = 1.0;
    playerAtkLabel.text = [NSString stringWithFormat:@"攻击力:%@",self.save.characterModel.attack];
    playerAtkLabel.textAlignment = NSTextAlignmentCenter;
    [backView3 addSubview:playerAtkLabel];
    //主角防御
    UILabel *playerDefLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(222), H(179), W(76), H(38))];
    playerDefLabel.layer.borderWidth = 1.0;
    playerDefLabel.text = [NSString stringWithFormat:@"防御力:%@",self.save.characterModel.defence];
    playerDefLabel.textAlignment = NSTextAlignmentCenter;
    [backView3 addSubview:playerDefLabel];
    //战斗按钮
    UIButton *battleBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(55), H(225), W(81), H(41))];
    battleBtn.layer.cornerRadius = 5;
    [battleBtn setTitle:@"战斗" forState:UIControlStateNormal];
    [battleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    battleBtn.layer.borderWidth = 4.0;
    [battleBtn addTarget:self action:@selector(battleBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [backView3 addSubview:battleBtn];
    //逃跑按钮
    UIButton *quitBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(161), H(225), W(81), H(41))];
    quitBtn.layer.cornerRadius = 5;
    [quitBtn setTitle:@"逃跑" forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    quitBtn.layer.borderWidth = 4.0;
    [quitBtn addTarget:self action:@selector(quitBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [backView3 addSubview:quitBtn];
    
}

-(void)battleBtnPressed{
    NSMutableString *resultStr;
    NSNumber *result;
    int soldierNum = [self.save.characterModel.soldierNum intValue];
    int characterHP = [self.save.characterModel.currentBlood intValue];
    int monsterHP = [self.currentMonster.blood intValue];
    while (!(characterHP<=0||monsterHP<=0)) {
        //玩家的实际攻击力
        int characterAttark = [self.save.characterModel.attack intValue]+soldierNum*0.2 - [self.currentMonster.defence intValue];
        //怪物的实际攻击力
        int monsterAttack = [self.currentMonster.attack intValue]-[self.save.characterModel.defence intValue]-soldierNum*0.1;
        if (characterAttark<=0) {
            characterAttark = 1;
        }
        if (monsterAttack<=0) {
            characterAttark = 1;
        }
        monsterHP = monsterHP - characterAttark;
        characterHP = characterHP - monsterAttack;
        if (characterHP<60&soldierNum>0) {
            characterHP = [self.save.characterModel.currentBlood intValue];
            soldierNum = soldierNum -1;
        }
    }
    if (characterHP>monsterHP) {
        //玩家胜利
        result = @1;
        resultStr = [NSMutableString stringWithFormat:@"你获胜了\n"];
        if ([self.save.characterModel.soldierNum intValue]-soldierNum>0) {
            [resultStr appendFormat:@"损失了%i个士兵\n",([self.save.characterModel.soldierNum intValue]-soldierNum)];
            self.save.characterModel.soldierNum = [NSNumber numberWithInt:soldierNum];
        }
        if (characterHP<[self.save.characterModel.currentBlood intValue]) {
            [resultStr appendFormat:@",损失了%i的血量\n",([self.save.characterModel.currentBlood intValue]-characterHP)];
            self.save.characterModel.soldierNum = [NSNumber numberWithInt:characterHP];
        }
        if (arc4random_uniform(10)<8) {
            int money = arc4random_uniform([self.currentMonster.blood intValue])+1;
            [resultStr appendFormat:@"获得了%i的钱币\n",money];
            self.save.characterModel.money = [NSNumber numberWithInt:[self.save.characterModel.money intValue]+money];
        }
        //获得物品
        if (arc4random_uniform(10)<4) {
            NSArray *thingsArr = @[@1003,@1005,@3010,@3020,@6015,@6018,@6040,@6050,@6060,@6080,@6100];
            NSNumber *getThing = thingsArr[arc4random_uniform(11)];
            NSArray *thingsList = [ThingModel allThingsList];
            ThingModel *thingModel;
            for (thingModel in thingsList) {
                if ([thingModel.thingId intValue]==[getThing intValue]) {
                    break;
                }
            }
            [resultStr appendFormat:@"获得了物品 %@\n",thingModel.name];
            [self.save addThingsWithId:[NSString stringWithFormat:@"%@",getThing] withNumber:@1];
        }
    }
    else{
        //怪物胜利
        result = @0;
        resultStr = [NSMutableString stringWithFormat:@"很遗憾,你失败了,请重新来过\n"];
    }
    [self dismissViewControllerAnimated:NO completion:^{
        [self.delegate battleViewPassMessage:resultStr withResult:result];
    }];
}

-(void)quitBtnPressed{
    NSMutableString *resultString = [NSMutableString stringWithString:@"你在战斗中逃跑了\n"];
    int money = [self.save.characterModel.money intValue];
    int soldier = [self.save.characterModel.soldierNum intValue];
    if (money>0) {
        money = money/2;
        money = arc4random_uniform(money)+1;
        self.save.characterModel.money = [NSNumber numberWithInt:([self.save.characterModel.money intValue]-money)];
        [resultString appendFormat:@"逃跑时太过匆忙丢失了%i的钱币\n",money];
    }
    if (arc4random_uniform(10)<4&&soldier>0) {
        soldier = soldier/2;
        soldier = arc4random_uniform(soldier);
        self.save.characterModel.soldierNum = [NSNumber numberWithInt:([self.save.characterModel.soldierNum intValue]-soldier)];
        [resultString appendFormat:@"逃跑时军队大乱逃跑了%i个士兵\n",soldier];
    }
    [self dismissViewControllerAnimated:NO completion:^{
        [self.delegate battleViewPassMessage:resultString withResult:@2];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
