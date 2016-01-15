//
//  AttackCityBattleViewController.m
//  GreenZone
//
//  Created by student on 15-7-8.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "AttackCityBattleViewController.h"
#import "Save.h"
#import "CityModel.h"
#import "ImageClip.h"
#import "GeneralModel.h"
#import "MapViewController.h"
#import "AudioTool.h"

@interface AttackCityBattleViewController (){
    int citySoliderNum;
    int playerSoliderNum;
    int playerCurrentSoliderNum;
    UIView *playerSoliderView;
    UIView *citySoliderView;
    UILabel *citySoliderLabel;
    UILabel *playerSoliderLabel;
    UIImageView *backView3;
}

@end

@implementation AttackCityBattleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    citySoliderNum = [self.city.residenceSoldiers intValue];
    playerSoliderNum = [self.soliderNum intValue];
    playerCurrentSoliderNum = [self.soliderNum intValue];
    [self createWindowUI];
}

-(void)viewWillAppear:(BOOL)animated{
    self.player = [AudioTool playMusic:@"attackCity.mp3"];
    self.player.numberOfLoops = NSNotFound;
}

-(void)viewDidAppear:(BOOL)animated{
    [self damageConsole];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player stop];
}

/**
 *  根据存档初始化
 */
-(instancetype)initWithSave:(Save *)save andCityModel:(CityModel *)city andAtkGeneral:(GeneralModel *)atkGeneral andSoliderNum:(NSNumber *)soliderNum{
    if (self = [super init])
    {
        self.save = save;
        self.city = city;
        self.atkGeneral = atkGeneral;
        self.soliderNum = soliderNum;
    }
    return self;
}

/**
 *  创建界面
 */
-(void)createWindowUI{

    //创建背景
    //刷地面背景
    UIImageView *backView1 = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(320), H(323))];
    backView1.image = [ImageClip imageWithPngName:@"CastleField"];
    [self.view addSubview:backView1];
    //刷天空背景
    UIImageView *backView2 = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(320), H(323))];
    backView2.image = [ImageClip imageWithPngName:@"CastleSky"];
    [self.view addSubview:backView2];
    
    //刷攻守人物
    //守城
    UIImageView *defendSoliderView1 = [[UIImageView alloc]initWithFrame:CGRectMake(W(65), H(151), W(32), H(32))];
    defendSoliderView1.image = [ImageClip imageWithPngName:@"defendSolider"];
    [backView2 addSubview:defendSoliderView1];
    UIImageView *defendSoliderView2 = [[UIImageView alloc]initWithFrame:CGRectMake(W(122), H(151), W(32), H(32))];
    defendSoliderView2.image = [ImageClip imageWithPngName:@"defendSolider"];
    [backView2 addSubview:defendSoliderView2];
    UIImageView *defendSoliderView3 = [[UIImageView alloc]initWithFrame:CGRectMake(W(177), H(151), W(32), H(32))];
    defendSoliderView3.image = [ImageClip imageWithPngName:@"defendSolider"];
    [backView2 addSubview:defendSoliderView3];
    UIImageView *defendSoliderView4 = [[UIImageView alloc]initWithFrame:CGRectMake(W(229), H(151), W(32), H(32))];
    defendSoliderView4.image = [ImageClip imageWithPngName:@"defendSolider"];
    [backView2 addSubview:defendSoliderView4];
    //攻城
    UIImageView *attackSoliderView1 = [[UIImageView alloc]initWithFrame:CGRectMake(W(65), H(270), W(32), H(32))];
    attackSoliderView1.image = [ImageClip imageWithPngName:@"attackSolider"];
    [backView2 addSubview:attackSoliderView1];
    UIImageView *attackSoliderView2 = [[UIImageView alloc]initWithFrame:CGRectMake(W(115), H(283), W(32), H(32))];
    attackSoliderView2.image = [ImageClip imageWithPngName:@"attackSolider"];
    [backView2 addSubview:attackSoliderView2];
    UIImageView *attackSoliderView3 = [[UIImageView alloc]initWithFrame:CGRectMake(W(165), H(283), W(32), H(32))];
    attackSoliderView3.image = [ImageClip imageWithPngName:@"attackSolider"];
    [backView2 addSubview:attackSoliderView3];
    UIImageView *attackSoliderView4 = [[UIImageView alloc]initWithFrame:CGRectMake(W(217), H(270), W(32), H(32))];
    attackSoliderView4.image = [ImageClip imageWithPngName:@"attackSolider"];
    [backView2 addSubview:attackSoliderView4];
    UIImageView *playerView = [[UIImageView alloc]initWithFrame:CGRectMake(W(144), H(243), W(32), H(32))];
    playerView.image = [ImageClip imageWithCharacterImage:self.save.characterModel.animationImage getByDirectionNumber:@3];
    [backView2 addSubview:playerView];
    
    //刷下方详细情况
    backView3 = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(323), W(320), H(245))];
    backView3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView3];
    //城市名字
    UILabel *cityNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(8), H(19), W(194), H(35))];
    cityNameLabel.layer.borderWidth = 1.0;
    cityNameLabel.text = self.city.name;
    cityNameLabel.textAlignment = NSTextAlignmentCenter;
    [backView3 addSubview:cityNameLabel];
    //城市兵力
    citySoliderView = [[UIView alloc]initWithFrame:CGRectMake(W(8), H(62), W(194), H(35))];
    [backView3 addSubview:citySoliderView];
    citySoliderLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(8), H(62), W(194), H(35))];
    [backView3 addSubview:citySoliderLabel];
    [self reloadCitySoliderView];
    //城市头像
    UIImageView *cityImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W(216), H(8), W(96), H(96))];
    cityImageView.image = [ImageClip imageWithPngName:@"cityImage"];
    cityImageView.layer.borderWidth = 1.0;
    [backView3 addSubview:cityImageView];
    //主角头像
    UIImageView *playerFaceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W(8), H(129), W(96), H(96))];
    playerFaceImageView.image = [ImageClip imageWithFaceImage:self.save.characterModel.faceImage getByLocation:@0];
    playerFaceImageView.layer.borderWidth = 1.0;
    [backView3 addSubview:playerFaceImageView];
    //主角姓名
    UILabel *playerNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(118), H(135), W(194), H(35))];
    playerNameLabel.layer.borderWidth = 1.0;
    playerNameLabel.text = self.save.characterModel.name;
    playerNameLabel.textAlignment = NSTextAlignmentCenter;
    [backView3 addSubview:playerNameLabel];
    //主角兵力
    playerSoliderView = [[UIView alloc]initWithFrame:CGRectMake(W(118), H(183), W(194), H(35))];
    [backView3 addSubview:playerSoliderView];
    playerSoliderLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(118), H(183), W(194), H(35))];
    [backView3 addSubview:playerSoliderLabel];
    [self reloadPlayerSoliderView];
}

/**
 *  城市剩余兵力
 */
-(void)reloadCitySoliderView{
    CGFloat scale =(double)citySoliderNum/[self.city.residenceSoldiers doubleValue];
    CGFloat width = scale*W(194);
    [UIView animateWithDuration:2.0 animations:^{
        citySoliderView.frame = CGRectMake(W(8), H(62), width, H(35));
    }];
    if (scale>=0.8) {
        citySoliderView.backgroundColor = [UIColor greenColor];
    }
    else if (scale>=0.5) {
        citySoliderView.backgroundColor = [UIColor colorWithRed:1.000 green:0.714 blue:0.028 alpha:1.000];
    }else{
        citySoliderView.backgroundColor = [UIColor redColor];
    }
    citySoliderLabel.textAlignment = NSTextAlignmentCenter;
    citySoliderLabel.text = [NSString stringWithFormat:@"剩余兵力:%.0f%@",scale*100,@"%"];
    citySoliderLabel.layer.borderWidth = 1;
}

/**
 *  主角剩余兵力
 */
-(void)reloadPlayerSoliderView{
    CGFloat scale = (double)playerCurrentSoliderNum/(double)playerSoliderNum;
    CGFloat width = scale*W(194);
    [UIView animateWithDuration:2.0 animations:^{
        playerSoliderView.frame = CGRectMake(W(118), H(183), width, H(35));
    }];
    if (scale>=0.8) {
        playerSoliderView.backgroundColor = [UIColor greenColor];
    }
    else if (scale>=0.5) {
        playerSoliderView.backgroundColor = [UIColor colorWithRed:1.000 green:0.714 blue:0.028 alpha:1.000];
    }else{
        playerSoliderView.backgroundColor = [UIColor redColor];
    }
    playerSoliderLabel.textAlignment = NSTextAlignmentCenter;
    playerSoliderLabel.text = [NSString stringWithFormat:@"剩余兵力:%.0f%@",scale*100,@"%"];
    playerSoliderLabel.layer.borderWidth = 1;
}

/**
 *  战斗计算(主角+武将+士兵VS城市+武将+士兵)
 */
-(void)damageConsole{
    playerCurrentSoliderNum = [self.soliderNum intValue];
    citySoliderNum = [self.city.residenceSoldiers intValue];
    while (!(playerCurrentSoliderNum<=0||citySoliderNum<=0)) {
        //主角的实际攻击力
        int characterAttack = [self.save.characterModel.attack intValue]+[self.atkGeneral.attack intValue]+playerCurrentSoliderNum*0.2-[self.city.defence intValue]-citySoliderNum*0.1;
        //城市的实际攻击力
        int cityAttack = [self.city.attack intValue]+[self.city.residenceSoldiers intValue]*0.2-[self.atkGeneral.defence intValue]-playerCurrentSoliderNum*0.1;
        if (characterAttack<=0) {
            characterAttack=1;
        }
        if (cityAttack<=0) {
            cityAttack =1;
        }
        characterAttack = characterAttack/10+1;
        cityAttack = cityAttack/10+1;
        citySoliderNum = citySoliderNum - characterAttack;
        if (citySoliderNum<0) {
            citySoliderNum=0;
            break;
        }
        playerCurrentSoliderNum = playerCurrentSoliderNum - cityAttack;
        if (playerCurrentSoliderNum<0) {
            playerCurrentSoliderNum = 0;
        }
        [[NSRunLoop mainRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
        [self reloadCitySoliderView];
        [self reloadPlayerSoliderView];
    }
    if (citySoliderNum>playerCurrentSoliderNum) {
        //失败
        self.city.residenceSoldiers = [NSNumber numberWithInt:(int)([self.city.residenceSoldiers intValue]*0.8)];
        self.save.characterModel.soldierNum = [NSNumber numberWithInt:([self.save.characterModel.soldierNum intValue]-[self.soliderNum intValue])];
        //有几率武将逃跑
        
        [self dismissViewControllerAnimated:NO completion:^{
            [self.delegate battleViewPassMessage:@"战斗失败，损失惨重" withResult:@2];
        }];
    }else{
        //获胜
        self.city.residenceSoldiers = @0;
        self.city.owner = @"player";
        //更改城市的拥有者
        NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.save.citiesArr];
        [tmpArr removeObject:self.city];
        self.save.citiesArr = tmpArr;
        tmpArr = [NSMutableArray arrayWithArray:self.save.characterModel.havingCities];
        [tmpArr addObject:self.city];
        //更改玩家带兵数
        self.save.characterModel.havingCities = tmpArr;
        self.save.characterModel.soldierNum = [NSNumber numberWithInt:([self.save.characterModel.soldierNum intValue]-[self.soliderNum intValue]+playerCurrentSoliderNum)];
        [self dismissViewControllerAnimated:NO completion:^{
            [self.delegate battleViewPassMessage:@"攻打胜利" withResult:@1];
        }];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
