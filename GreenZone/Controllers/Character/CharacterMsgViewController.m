//
//  CharacterMsgViewController.m
//  GreenZone
//
//  Created by student on 15/7/5.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "CharacterMsgViewController.h"
#import "Save.h"
#import "ImageClip.h"
#import "CityModel.h"
#import "AudioTool.h"

@interface CharacterMsgViewController ()

@end

@implementation CharacterMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"基本信息";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(gotoBack)];
    self.navigationItem.leftBarButtonItem = item;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createWindowUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.player = [AudioTool playMusic:@"map1.mp3"];
    self.player.numberOfLoops = NSNotFound;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.player stop];
}

/**
 *  返回上个界面
 */
-(void)gotoBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/**
 *  通过存档初始化
 */
-(instancetype)initWithSave:(Save *)save{
    if (self = [super init]) {
        self.save = save;
    }
    return self;
}

/**
 *  创建界面
 */
-(void)createWindowUI{
    //创建背景
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WinWidth, WinHeight)];
    backView.image = [ImageClip imageWithPngName:@"Book"];
    backView.alpha = 0.5;
    [self.view addSubview:backView];
    //创建头像显示
    UIImageView *faceView = [[UIImageView alloc]initWithFrame:CGRectMake(W(14), H(55), W(96), H(96))];
    faceView.image = [ImageClip imageWithFaceImage:self.save.characterModel.faceImage getByLocation:@0];
    faceView.layer.borderWidth = 1.0;
    [self.view addSubview:faceView];
    //创建姓名显示
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(125), H(55), W(180), H(30))];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = self.save.characterModel.name;
    nameLabel.layer.borderWidth = 1;
    [self.view addSubview:nameLabel];
    //创建hp显示
    [self reloadHPView];
    //创建行动力显示
    [self reloadActiveView];
    //创建攻击力显示
    UILabel *attackLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(14), H(159), W(142), H(32))];
    attackLabel.textAlignment = NSTextAlignmentCenter;
    attackLabel.text = [NSString stringWithFormat:@"攻击力:%@",self.save.characterModel.attack];
    attackLabel.layer.borderWidth = 1;
    [self.view addSubview:attackLabel];
    //创建防御力显示
    UILabel *defenceLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(163), H(159), W(142), H(32))];
    defenceLabel.textAlignment = NSTextAlignmentCenter;
    defenceLabel.text = [NSString stringWithFormat:@"防御力:%@",self.save.characterModel.defence];
    defenceLabel.layer.borderWidth = 1;
    [self.view addSubview:defenceLabel];
    //创建拥有城市数量显示
    UILabel *cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(14), H(199), W(142), H(32))];
    cityLabel.textAlignment = NSTextAlignmentCenter;
    cityLabel.text = [NSString stringWithFormat:@"拥有城市数量:%lu",self.save.characterModel.havingCities.count];
    cityLabel.layer.borderWidth = 1;
    [self.view addSubview:cityLabel];
    //创建拥有武将数量显示
    UILabel *generalLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(163), H(199), W(142), H(32))];
    generalLabel.textAlignment = NSTextAlignmentCenter;
    generalLabel.text = [NSString stringWithFormat:@"拥有武将数量:%lu",self.save.characterModel.allGeneral.count];
    generalLabel.layer.borderWidth = 1;
    [self.view addSubview:generalLabel];
    //创建拥有士兵数量显示
    UILabel *soldierLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(14), H(239), W(142), H(32))];
    soldierLabel.textAlignment = NSTextAlignmentCenter;
    soldierLabel.text = [NSString stringWithFormat:@"拥有士兵数量:%@",self.save.characterModel.soldierNum];
    soldierLabel.layer.borderWidth = 1;
    [self.view addSubview:soldierLabel];
    //创建拥有钱币数量显示
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(163), H(239), W(142), H(32))];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.text = [NSString stringWithFormat:@"拥有钱币数量:%@",self.save.characterModel.money];
    moneyLabel.layer.borderWidth = 1;
    [self.view addSubview:moneyLabel];
    //创建游戏进度显示
    UILabel *gameWinLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(14), H(290), W(291), H(32))];
    gameWinLabel.textAlignment = NSTextAlignmentCenter;
    gameWinLabel.text = [NSString stringWithFormat:@"游戏胜利进度"];
    gameWinLabel.layer.borderWidth = 1;
    [self.view addSubview:gameWinLabel];
    //占领进度显示
    UILabel *ruleWinLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(14), H(332), W(83), H(32))];
    ruleWinLabel.textAlignment = NSTextAlignmentCenter;
    ruleWinLabel.text = [NSString stringWithFormat:@"统治胜利"];
    ruleWinLabel.layer.borderWidth = 1;
    [self.view addSubview:ruleWinLabel];
    [self reloadRuleView];
    //收集武将显示
    UILabel *generalWinLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(14), H(380), W(83), H(32))];
    generalWinLabel.textAlignment = NSTextAlignmentCenter;
    generalWinLabel.text = [NSString stringWithFormat:@"收集胜利"];
    generalWinLabel.layer.borderWidth = 1;
    [self.view addSubview:generalWinLabel];
    [self reloadGeneralView];
    //荣誉显示
    UILabel *honourWinLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(14), H(428), W(83), H(32))];
    honourWinLabel.textAlignment = NSTextAlignmentCenter;
    honourWinLabel.text = [NSString stringWithFormat:@"荣誉胜利"];
    honourWinLabel.layer.borderWidth = 1;
    [self.view addSubview:honourWinLabel];
    [self reloadHonourView];
    //钱币显示
    UILabel *moneyWinLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(14), H(476), W(83), H(32))];
    moneyWinLabel.textAlignment = NSTextAlignmentCenter;
    moneyWinLabel.text = [NSString stringWithFormat:@"富豪胜利"];
    moneyWinLabel.layer.borderWidth = 1;
    [self.view addSubview:moneyWinLabel];
    [self reloadMoneyView];
}

/**
 *  刷新血量的显示
 */
-(void)reloadHPView{
    UIView *hpView = [[UIView alloc]initWithFrame:CGRectMake(W(125), H(89), 0, H(28))];
    [self.view addSubview:hpView];
    CGFloat scale = [self.save.characterModel.currentBlood doubleValue]/[self.save.characterModel.blood doubleValue];
    CGFloat width = scale*W(180);
    [UIView animateWithDuration:2.0 animations:^{
        hpView.frame = CGRectMake(W(125), H(89), width, H(28));
    }];
    if (scale>=0.8) {
        hpView.backgroundColor = [UIColor greenColor];
    }
    else if (scale>=0.5) {
        hpView.backgroundColor = [UIColor colorWithRed:1.000 green:0.714 blue:0.028 alpha:1.000];
    }else{
        hpView.backgroundColor = [UIColor redColor];
    }
    UILabel *hpLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(125), H(89), W(180), H(28))];
    hpLabel.textAlignment = NSTextAlignmentCenter;
    hpLabel.text = [NSString stringWithFormat:@"当前HP:%.0f%@",scale*100,@"%"];
    hpLabel.layer.borderWidth = 1;
    [self.view addSubview:hpLabel];
}

/**
 *  刷新行动力的显示
 */
-(void)reloadActiveView{
    UIView *activeView = [[UIView alloc]initWithFrame:CGRectMake(W(125), H(123), 0, H(28))];
    [self.view addSubview:activeView];
    CGFloat scale = [self.save.characterModel.power doubleValue]/100;
    CGFloat width = scale * W(180);
    [UIView animateWithDuration:2.0 animations:^{
        activeView.frame = CGRectMake(W(125), W(123), width, H(28));
    }];
    if (scale>=0.8) {
        activeView.backgroundColor = [UIColor blueColor];
    }
    else if (scale>=0.5) {
        activeView.backgroundColor = [UIColor colorWithRed:0.308 green:0.419 blue:1.000 alpha:1.000]
        ;
    }else{
        activeView.backgroundColor = [UIColor colorWithRed:0.436 green:1.000 blue:0.882 alpha:1.000];
    }
    UILabel *activeLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(125), H(123), W(180), H(28))];
    activeLabel.textAlignment = NSTextAlignmentCenter;
    activeLabel.layer.borderWidth = 1;
    activeLabel.text = [NSString stringWithFormat:@"行动力:%.0f%@",[self.save.characterModel.power doubleValue],@"%"];
    [self.view addSubview:activeLabel];
}

/**
 *  刷新占领进度
 */
-(void)reloadRuleView{
    UIView *ruleView = [[UIView alloc]initWithFrame:CGRectMake(W(105), H(332), 0, H(32))];
    ruleView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:ruleView];
    CGFloat scale;
    if (self.save.characterModel.havingCities.count!=0&&self.save.citiesArr.count!=0) {
        scale = (double)self.save.characterModel.havingCities.count/(self.save.characterModel.havingCities.count+self.save.citiesArr.count);
    }else{
        scale = 0;
    }
    CGFloat width = scale*W(200);
    [UIView animateWithDuration:2.0 animations:^{
        ruleView.frame = CGRectMake(W(105), H(332), width, H(32));
    }];
    UILabel *ruleLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(105), H(332), W(200), H(32))];
    ruleLabel.textAlignment = NSTextAlignmentCenter;
    ruleLabel.text = [NSString stringWithFormat:@"城市拥有:%.0f%@",scale*100,@"%"];
    ruleLabel.layer.borderWidth = 1;
    [self.view addSubview:ruleLabel];
}

/**
 *  刷新武将进度
 */
-(void)reloadGeneralView{
    UIView *generalView = [[UIView alloc]initWithFrame:CGRectMake(W(105), H(380), 0, H(32))];
    generalView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:generalView];
    CGFloat scale;
    if (self.save.characterModel.allGeneral.count!=0&&self.save.generalArr.count!=0) {
        scale = (double)self.save.characterModel.allGeneral.count/(self.save.characterModel.allGeneral.count+self.save.generalArr.count);
    }else{
        scale = 0;
    }
    CGFloat width = scale*W(200);
    [UIView animateWithDuration:2.0 animations:^{
        generalView.frame = CGRectMake(W(105), H(380), width, H(32));
    }];
    UILabel *generalLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(105), H(380), W(200), H(32))];
    generalLabel.textAlignment = NSTextAlignmentCenter;
    generalLabel.text = [NSString stringWithFormat:@"武将拥有:%.0f%@",scale*100,@"%"];
    generalLabel.layer.borderWidth = 1;
    [self.view addSubview:generalLabel];
}

/**
 *  刷新荣誉进度
 */
-(void)reloadHonourView{
    UIView *honourView = [[UIView alloc]initWithFrame:CGRectMake(W(105), H(428), 0, H(32))];
    honourView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:honourView];
    CGFloat totalMana = 0;
    for (CityModel *city in self.save.characterModel.havingCities) {
        totalMana = totalMana + [city.mana intValue];
    }
    CGFloat scale;
    scale = totalMana/8000;
    CGFloat width = scale*W(200);
    [UIView animateWithDuration:2.0 animations:^{
        honourView.frame = CGRectMake(W(105), H(428), width, H(32));
    }];
    UILabel *honourLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(105), H(428), W(200), H(32))];
    honourLabel.textAlignment = NSTextAlignmentCenter;
    honourLabel.text = [NSString stringWithFormat:@"城市威望:%.0f%@",scale*100,@"%"];
    honourLabel.layer.borderWidth = 1;
    [self.view addSubview:honourLabel];
}

/**
 *  刷新金钱进度
 */
-(void)reloadMoneyView{
    UIView *moneyView = [[UIView alloc]initWithFrame:CGRectMake(W(105), H(476), 0, H(32))];
    moneyView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:moneyView];
    CGFloat scale;
    scale = [self.save.characterModel.money intValue]/99999.0;
    CGFloat width = scale*W(200);
    [UIView animateWithDuration:2.0 animations:^{
        moneyView.frame = CGRectMake(W(105), H(476), width, H(32));
    }];
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(105), H(476), W(200), H(32))];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.text = [NSString stringWithFormat:@"金钱拥有:%.0f%@",scale*100,@"%"];
    moneyLabel.layer.borderWidth = 1;
    [self.view addSubview:moneyLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
