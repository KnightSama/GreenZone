//
//  CityEventViewController.m
//  GreenZone
//
//  Created by student on 15/7/7.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "CityEventViewController.h"
#import "CityModel.h"
#import "Save.h"
#import "ImageClip.h"
#import "GeneralModel.h"
#import "CheckGeneralTableViewController.h"
#import "KKNavigationController.h"
#import "AudioTool.h"
@interface CityEventViewController ()
{
    /**
     *  交纳的过路费
     */
    int roadTollnumber;
    
    //判断选择武将是出战还是驻守（初始为0，1为出战，2为驻守）
    int flag;
}


@end

@implementation CityEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = 0;
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:self.backImage];
    [self.view addSubview:imageView];
    int mark=0;
    CityModel *city = [[CityModel alloc]init];
    for (city in self.save.citiesArr) {
        if ([city.cityId intValue]==[self.number intValue]) {
            mark = 1;
            break;
        }
    }
    if (mark==1) {
        self.city = city;
        [self showViewForOtherCity:city];
    }else{
        for (city in self.save.characterModel.havingCities) {
            if ([city.cityId intValue]==[self.number intValue]) {
                break;
            }
        }
        self.city = city;
        [self showViewForSelfCity:city];
    }
    
    
//    /**
//     *  测试征兵
//     *
//     *  @return <#return value description#>
//     */
//    self.save.characterModel.money = [NSNumber numberWithInt:10000];
    

}

-(void)viewWillAppear:(BOOL)animated{
    self.player = [AudioTool playMusic:@"city.mp3"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  通过视图初始化
 */
-(instancetype)initWithView:(UIView *)view WithNumber:(NSNumber *)number withSave:(Save *)save{
    if (self = [super init]) {
        self.backImage = [ImageClip getSnapshotImageWithView:view];
        self.number = number;
        self.save = save;
    }
    return self;
}

/**
 *  弹出自己城市窗口
 */
-(NSString *)showViewForSelfCity:(CityModel *)city{
    //创建view显示在窗口上
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    view.center = CGPointMake(WinWidth/2, WinHeight/2);
    [self.view addSubview:view];
    //创建背景图
    UIImageView *imageBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    imageBack.image = [ImageClip imageWithJpgName:@"messageBG"];
    [view addSubview:imageBack];
    //创建背景边框
    UIImageView *imageBorder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    imageBorder.image = [ImageClip imageWithPngName:@"messageBorder1"];
    [view addSubview:imageBorder];
    //创建城市名标签
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(33), H(44), W(228), H(27))];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = [NSString stringWithFormat:@"到达了自己的城市:%@",city.name];
    [view addSubview:nameLabel];
    //创建驻守武将view
    UIView *generalView = [[UIView alloc]initWithFrame:CGRectMake(W(33), H(79), W(104), H(27))];
    [view addSubview:generalView];
    UIImageView *generalIcon = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(27), H(27))];
    generalIcon.image = [ImageClip imageWithPngName:@"icon9b"];
    [generalView addSubview:generalIcon];
    UILabel *generalLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(27), H(0), W(77), H(27))];
    GeneralModel *general = [[GeneralModel alloc]init];
    for (general in self.save.characterModel.allGeneral) {
        if ([general.generalId intValue]==[city.residenceGeneral intValue]) {
            break;
        }
    }
    generalLabel.layer.borderWidth = 1.0;
    generalLabel.textAlignment = NSTextAlignmentCenter;
    if (!general.name||[general.name isEqualToString:@""]) {
        generalLabel.text = @"未驻守";
    }
    else
    {
        generalLabel.text = general.name;
    }
    [generalView addSubview:generalLabel];
    //创建驻守士兵数View
    UIView *soldierView = [[UIView alloc]initWithFrame:CGRectMake(W(157), H(79), W(104), H(27))];
    [view addSubview:soldierView];
    UIImageView *soldierIcon = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(27), H(27))];
    soldierIcon.image = [ImageClip imageWithPngName:@"icon80b"];
    [soldierView addSubview:soldierIcon];
    UILabel *soldierLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(27), H(0), W(77), H(27))];
    soldierLabel.layer.borderWidth = 1.0;
    soldierLabel.textAlignment = NSTextAlignmentCenter;
    soldierLabel.text = [NSString stringWithFormat:@"%@",city.residenceSoldiers];
    [soldierView addSubview:soldierLabel];
    //创建攻击力
    UIView *attarkView = [[UIView alloc]initWithFrame:CGRectMake(W(33), H(114), W(104), H(27))];
    [view addSubview:attarkView];
    UIImageView *attarkIcon = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(27), H(27))];
    attarkIcon.image = [ImageClip imageWithPngName:@"icon07"];
    [attarkView addSubview:attarkIcon];
    UILabel *attarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(27), H(0), W(77), H(27))];
    attarkLabel.layer.borderWidth = 1.0;
    attarkLabel.textAlignment = NSTextAlignmentCenter;
    attarkLabel.text = [NSString stringWithFormat:@"%@",city.attack];
    [attarkView addSubview:attarkLabel];
    //创建防御力
    UIView *defenceView = [[UIView alloc]initWithFrame:CGRectMake(W(157), H(114), W(104), H(27))];
    [view addSubview:defenceView];
    UIImageView *defenceIcon = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(27), H(27))];
    defenceIcon.image = [ImageClip imageWithPngName:@"icon01"];
    [defenceView addSubview:defenceIcon];
    UILabel *defenceLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(27), H(0), W(77), H(27))];
    defenceLabel.layer.borderWidth = 1.0;
    defenceLabel.textAlignment = NSTextAlignmentCenter;
    defenceLabel.text = [NSString stringWithFormat:@"%@",city.defence];
    [defenceView addSubview:defenceLabel];
    //创建威望
    UIView *manaView = [[UIView alloc]initWithFrame:CGRectMake(W(33), H(149), W(104), H(27))];
    [view addSubview:manaView];
    UIImageView *manaIcon = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(27), H(27))];
    manaIcon.image = [ImageClip imageWithPngName:@"icon47b"];
    [manaView addSubview:manaIcon];
    UILabel *manaLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(27), H(0), W(77), H(27))];
    manaLabel.layer.borderWidth = 1.0;
    manaLabel.textAlignment = NSTextAlignmentCenter;
    manaLabel.text = [NSString stringWithFormat:@"%@",city.mana];
    [manaView addSubview:manaLabel];
    //创建税收
    UIView *outputView = [[UIView alloc]initWithFrame:CGRectMake(W(157), H(149), W(104), H(27))];
    [view addSubview:outputView];
    UIImageView *outputIcon = [[UIImageView alloc]initWithFrame:CGRectMake(W(0), H(0), W(27), H(27))];
    outputIcon.image = [ImageClip imageWithPngName:@"icon17b"];
    [outputView addSubview:outputIcon];
    UILabel *outputLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(27), H(0), W(77), H(27))];
    outputLabel.layer.borderWidth = 1.0;
    outputLabel.textAlignment = NSTextAlignmentCenter;
    outputLabel.text = [NSString stringWithFormat:@"%@",[city.output valueForKey:@"number"]];
    [outputView addSubview:outputLabel];
    //创建驻兵按钮
    UIButton *soldierBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(70), H(184), W(50), H(27))];
    soldierBtn.layer.borderWidth = 1.0;
    [soldierBtn setTitle:@"驻兵" forState:UIControlStateNormal];
    [soldierBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [soldierBtn addTarget:self action:@selector(putSoldierToCity:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:soldierBtn];
    //创建取消按钮
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(200), H(184), W(50), H(27))];
    cancelBtn.layer.borderWidth = 1.0;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:cancelBtn];
    
    //创建征兵按钮
    UIButton  *collectSoldierBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(135), H(184), W(50), H(27))];
    collectSoldierBtn.layer.borderWidth = 1.0;
    [collectSoldierBtn setTitle:@"征兵" forState:UIControlStateNormal];
    [collectSoldierBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [collectSoldierBtn addTarget:self action:@selector(collectSoldier:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:collectSoldierBtn];
    return nil;
}

//征兵事件
-(void)collectSoldier:(UIButton *)btn
{
    [btn.superview removeFromSuperview];
    
    //创建视图并设置背景
    UIView *collectView = [[UIView alloc]initWithFrame:CGRectMake(0, H(110), W(294), H(243))];
    collectView.center = CGPointMake(WinWidth/2, WinHeight/2);
    [self.view addSubview:collectView];
    
    UIImageView *BG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    BG.image = [ImageClip imageWithJpgName:@"messageBG"];
    [collectView addSubview:BG];
    UIImageView *border = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    border.image = [ImageClip imageWithPngName:@"messageBorder1"];
    [collectView addSubview:border];
    
    //标题label
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(30), H(40), W(234), H(37))];
    titleLabel.text = @"征  兵";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.layer.borderWidth = 1.0;
    [collectView addSubview:titleLabel];
    
    //剩余金钱提示label
    _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(85), H(85), W(150), H(40))];
    _moneyLabel.text = [NSString stringWithFormat:@"剩余钱：%@",self.save.characterModel.money];
    _moneyLabel.layer.borderWidth = 1.0;
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    [collectView addSubview:_moneyLabel];
    
    //征兵数label
    _collectNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(16), H(134), W(140), H(40))];
    _collectNumLabel.text = @"征兵数：0";
    _collectNumLabel.textAlignment = NSTextAlignmentCenter;
    _collectNumLabel.layer.borderWidth = 1.0;
    [collectView addSubview:_collectNumLabel];
    
    //征兵数字条
    self.collectSlide = [[UISlider alloc]initWithFrame:CGRectMake(W(170), H(139), W(118), H(31))];;
    self.collectSlide.minimumValue = 0;
    self.collectSlide.maximumValue = [self.save.characterModel.money intValue]/(1500-[self.city.mana intValue]*10);
    self.collectSlide.value = 0;
    [self.collectSlide addTarget:self action:@selector(collectChanged:) forControlEvents:UIControlEventValueChanged];
    [collectView addSubview:self.collectSlide];
    
    //确定按钮
    
    UIButton *confirmCollect = [[UIButton alloc]initWithFrame:CGRectMake(W(127), H(180), W(66), H(31))];
    [confirmCollect setTitle:@"确认" forState:UIControlStateNormal];
    [confirmCollect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmCollect.layer.borderWidth = 1.0;
    [confirmCollect addTarget:self action:@selector(collectConfirm) forControlEvents:UIControlEventTouchUpInside];
    [collectView addSubview:confirmCollect];
}

/**
 *  征兵确认
 */
-(void)collectConfirm
{
    //玩家金钱改变
    int money = [self.save.characterModel.money intValue] - ((1500-[self.city.mana intValue]*10)*(int)self.collectSlide.value);
    self.save.characterModel.money = [NSNumber numberWithInt:money];
    
    //玩家携带士兵数改变
    
    int num = [self.save.characterModel.soldierNum intValue] + (int)self.collectSlide.value;
    self.save.characterModel.soldierNum = [NSNumber numberWithInt:num];
    
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

/**
 *  征兵数字条改变
 */
-(void)collectChanged:(UISlider *)slider
{
    //改变剩余钱
    int money = [self.save.characterModel.money intValue] -((1500-[self.city.mana intValue]*10)*(int)slider.value);
//    self.save.characterModel.money = [NSNumber numberWithInt:money];
    if ((int)slider.value == 0) {
        money = [self.save.characterModel.money intValue];
    }
    self.moneyLabel.text = [NSString stringWithFormat:@"剩余钱：%i",money];
    
    //改变征兵数
    self.collectNumLabel.text = [NSString stringWithFormat:@"征兵数：%i",(int)slider.value];
}

/**
 *  驻守兵力
 */
-(void)putSoldierToCity:(UIButton *)btn{
    [btn.superview removeFromSuperview];
    //创建view显示在窗口上
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    view.center = CGPointMake(WinWidth/2, WinHeight/2);
    [self.view addSubview:view];
    //创建背景图
    UIImageView *imageBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    imageBack.image = [ImageClip imageWithJpgName:@"messageBG"];
    [view addSubview:imageBack];
    //创建背景边框
    UIImageView *imageBorder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    imageBorder.image = [ImageClip imageWithPngName:@"messageBorder1"];
    [view addSubview:imageBorder];
    //创建标题名标签
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(90), H(44), W(104), H(27))];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = @"驻守";
    [view addSubview:nameLabel];
    //创建驻守武将view
    self.residenceGeneralLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(16), H(79), W(171), H(27))];
    
#warning 修改了general
//    GeneralModel *general = [[GeneralModel alloc]init];
//    for (general in self.save.characterModel.allGeneral) {
//        if ([general.generalId intValue]==[self.city.residenceGeneral intValue]) {
//            break;
//        }
//    }
    self.residenceGeneralLabel.layer.borderWidth = 1.0;
    self.residenceGeneralLabel.textAlignment = NSTextAlignmentCenter;
    if (!self.city.residenceGeneral||[self.city.residenceGeneral isEqualToString:@""]) {
        self.residenceGeneralLabel.text = @"未驻守";
    }
    else
    {
        self.residenceGeneralLabel.text = [NSString stringWithFormat:@"驻守武将：%@",self.city.residenceGeneral];
    }
    
    [view addSubview:self.residenceGeneralLabel];
    //创建驻守武将按钮
    UIButton *generalBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(202), H(79), W(73), H(27))];
    generalBtn.layer.borderWidth = 1.0;
    [generalBtn setTitle:@"驻守武将" forState:UIControlStateNormal];
    [generalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [generalBtn addTarget:self action:@selector(putGeneralToCity:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:generalBtn];
    //创建驻守士兵数View
    UILabel *soldierLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(16), H(114), W(129), H(27))];
    soldierLabel.layer.borderWidth = 1.0;
    soldierLabel.textAlignment = NSTextAlignmentCenter;
    soldierLabel.text = [NSString stringWithFormat:@"现有驻兵数:%@",self.city.residenceSoldiers];
    self.soldierLabel = soldierLabel;
    [view addSubview:soldierLabel];
    //创建携带士兵数View
    UILabel *carrySoldierLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(160), H(114), W(120), H(27))];
    carrySoldierLabel.layer.borderWidth = 1.0;
    carrySoldierLabel.textAlignment = NSTextAlignmentCenter;
    carrySoldierLabel.text = [NSString stringWithFormat:@"携带士兵:%@",self.save.characterModel.soldierNum];
    self.carraySoldierLabel = carrySoldierLabel;
    [view addSubview:carrySoldierLabel];
    //创建更改士兵数View
    UILabel *changeSoldierLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(16), H(150), W(97), H(27))];
    changeSoldierLabel.layer.borderWidth = 1.0;
    changeSoldierLabel.textAlignment = NSTextAlignmentCenter;
    changeSoldierLabel.text = @"更改驻兵数";
    [view addSubview:changeSoldierLabel];
    //创建更改士兵数滑动条
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(W(124), H(149), W(159), H(31))];
    slider.minimumValue = 0;
    slider.maximumValue = [self.save.characterModel.soldierNum intValue] + [self.city.residenceSoldiers intValue];
    slider.value = [self.city.residenceSoldiers intValue];
    [slider addTarget:self action:@selector(changeSoldierNumber:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:slider];
    //创建确定按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(W(106), H(185), W(73), H(27))];
    button.layer.borderWidth = 1.0;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:button];
}

/**
 *  取消
 */
-(void)cancel:(UIButton *)btn{
    [self dismissViewControllerAnimated:NO completion:^{
    }];
}

/**
 *  驻守武将
 */
-(void)putGeneralToCity:(UIButton *)btn{
    flag = 2;
    
    //将城市的原有武将加入主角携带武将数组
    for (GeneralModel *tmp in self.save.characterModel.allGeneral) {
        if ([tmp.name isEqualToString:self.city.residenceGeneral]) {
            [self.save.characterModel.carryingGeneral addObject:tmp];
            self.city.residenceGeneral = @"";
        }
    }
    
    CheckGeneralTableViewController *checkGeneralController = [[CheckGeneralTableViewController alloc]initWithSave:self.save];
    checkGeneralController.delegate = self;
    KKNavigationController *kkController = [[KKNavigationController alloc]initWithRootViewController:checkGeneralController];
    [self presentViewController:kkController animated:YES completion:^{
        
    }];
    
}

/**
 *  更改驻守士兵的数量
 */
-(void)changeSoldierNumber:(UISlider *)slider{
    int oldNum = [self.city.residenceSoldiers intValue];
    int nowNum = slider.value;
    self.city.residenceSoldiers = [NSNumber numberWithInt:nowNum];
    self.save.characterModel.soldierNum = [NSNumber numberWithInt:([self.save.characterModel.soldierNum intValue]-(nowNum-oldNum))];
    self.soldierLabel.text = [NSString stringWithFormat:@"现有驻兵数:%@",self.city.residenceSoldiers];
    self.carraySoldierLabel.text = [NSString stringWithFormat:@"携带士兵:%@",self.save.characterModel.soldierNum];
}

/**
 *  弹出其他城市窗口
 */
-(NSString *)showViewForOtherCity:(CityModel *)city{
    UIView *cityDescription = [[UIView alloc]initWithFrame:CGRectMake(W(0), H(0), W(294), H(225))];
    cityDescription.center = CGPointMake(WinWidth/2, WinHeight/2);
    [self.view addSubview:cityDescription];
    UIImageView *BG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    BG.image = [ImageClip imageWithJpgName:@"messageBG"];
    [cityDescription addSubview:BG];
    UIImageView *border = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    border.image = [ImageClip imageWithPngName:@"messageBorder1"];
    [cityDescription addSubview:border];
    
    //城市名
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(31), H(43), W(233), H(27))];
    titleLabel.text = [NSString stringWithFormat:@"到达了城市:%@",city.name];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [cityDescription addSubview:titleLabel];
    
    //城市攻击力和防御力
    UIView *attView = [[UIView alloc]initWithFrame:CGRectMake(W(31), H(78), W(104), H(27))];
    UIImageView *attImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(27), H(27))];
    attImageView.image = [ImageClip imageWithPngName:@"icon07"];
    [attView addSubview:attImageView];
    
    UILabel *attLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(40), 0, W(64), H(27))];
    attLabel.text = [NSString stringWithFormat:@"%li",[city.attack integerValue]];
    attLabel.textAlignment = NSTextAlignmentCenter;
    attLabel.layer.borderWidth = 1.0;
    [attView addSubview:attLabel];
    [cityDescription addSubview:attView];
    
    UIView *defView = [[UIView alloc]initWithFrame:CGRectMake(W(160), H(78), W(104), H(27))];
    UIImageView *defImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(27), H(27))];
    defImageView.image = [ImageClip imageWithPngName:@"icon01"];
    [defView addSubview:defImageView];
    
    UILabel *defLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(40), 0, W(64), H(27))];
    defLabel.text = [NSString stringWithFormat:@"%li",[city.defence integerValue]];
    defLabel.textAlignment = NSTextAlignmentCenter;
    defLabel.layer.borderWidth = 1.0;
    [defView addSubview:defLabel];
    [cityDescription addSubview:defView];
    
    //城市的拥有者和税收
    UIView *ownerView = [[UIView alloc]initWithFrame:CGRectMake(W(31), H(108), W(104), H(27))];
    UIImageView *ownerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(27), H(27))];
    ownerImageView.image = [ImageClip imageWithPngName:@"icon47"];
    [ownerView addSubview:ownerImageView];
    
    UILabel *ownerLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(40), 0, W(64), H(27))];
    ownerLabel.text = city.owner;
    ownerLabel.textAlignment = NSTextAlignmentCenter;
    ownerLabel.layer.borderWidth = 1.0;
    
    [ownerView addSubview:ownerLabel];
    [cityDescription addSubview:ownerView];
    
    UIView *roadTollView = [[UIView alloc]initWithFrame:CGRectMake(W(160), H(108), W(104), H(27))];
    UIImageView *roadTollImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(27), H(27))];
    roadTollImageView.image = [ImageClip imageWithPngName:@"flaticon_63"];
    [roadTollView addSubview:roadTollImageView];
    
    UILabel *roadTollLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(40), 0, W(64), H(27))];
    roadTollLabel.text = [NSString stringWithFormat:@"%li",[city.roadToll integerValue]];
    roadTollLabel.textAlignment = NSTextAlignmentCenter;
    roadTollLabel.layer.borderWidth = 1.0;
    
    [roadTollView addSubview:roadTollLabel];
    [cityDescription addSubview:roadTollView];
    
    //城市介绍
    UITextView *description = [[UITextView alloc]initWithFrame:CGRectMake(W(31), H(143), W(233), H(38))];
    description.backgroundColor = [UIColor clearColor];
    description.layer.borderWidth = 1.0;
    description.text = city.cityDescription;
    description.editable = NO;
    
    [cityDescription addSubview:description];
    
    //缴纳过路费
    UIButton *roadTollBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(62), H(184), W(73), H(27))];
    [roadTollBtn setTitle:@"交过路费" forState:UIControlStateNormal];
    [roadTollBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [roadTollBtn addTarget:self action:@selector(giveRoadToll:) forControlEvents:UIControlEventTouchUpInside];
    [cityDescription addSubview:roadTollBtn];
    
    //攻打城市
    UIButton *attackCityBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(155), H(184), W(73), H(27))];
    [attackCityBtn setTitle:@"攻打" forState:UIControlStateNormal];
    [attackCityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [attackCityBtn addTarget:self action:@selector(attackCity:) forControlEvents:UIControlEventTouchUpInside];
    [cityDescription addSubview:attackCityBtn];
    return nil;
}


//攻打城市
-(void)attackCity:(UIButton *)btn
{
    [btn.superview removeFromSuperview];
    UIView *attView = [[UIView alloc]initWithFrame:CGRectMake(W(0), H(0), W(294), H(225))];
    attView.center = CGPointMake(WinWidth/2, WinHeight/2);
    [self.view addSubview:attView];
    
    UIImageView *BG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    BG.image = [ImageClip imageWithJpgName:@"messageBG"];
    [attView addSubview:BG];
    UIImageView *border = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    border.image = [ImageClip imageWithPngName:@"messageBorder1"];
    [attView addSubview:border];
    
    
    //攻打标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(90), H(44), W(104), H(27))];
    titleLabel.text = @"攻打城市";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.layer.borderWidth = 1.0;
    [attView addSubview:titleLabel];
    
    //选择出战武将提示
    self.generalLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(16), H(79), W(171), H(27))];
    self.generalLabel.text = [NSString stringWithFormat:@"出战武将:%@",@"未选择"];
    self.generalLabel.textAlignment = NSTextAlignmentCenter;
    self.generalLabel.layer.borderWidth = 1.0;
    [attView addSubview:self.generalLabel];
    
    //武将选择
    UIButton *checkGeneralBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(202), H(79), W(73), H(27))];
    checkGeneralBtn.layer.borderWidth = 1.0;
    [checkGeneralBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkGeneralBtn setTitle:@"选择武将" forState:UIControlStateNormal];
    [checkGeneralBtn addTarget:self action:@selector(checkGeneral) forControlEvents:UIControlEventTouchUpInside];
    [attView addSubview:checkGeneralBtn];
    
    //出战士兵数选择
    self.soldierSlide = [[UISlider alloc]initWithFrame:CGRectMake(W(156), H(121), W(122), H(31))];
    self.soldierSlide.maximumValue =MIN([self.save.characterModel.soldierNum intValue], 0);
    self.soldierSlide.minimumValue = 0;
    [self.soldierSlide addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [attView addSubview:self.soldierSlide];
    
    //选择出战士兵数提示
    _checkSoldierLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(16), H(124), W(134), H(27))];
    _checkSoldierLabel.text = [NSString stringWithFormat:@"出战的士兵数:%.f",self.soldierSlide.value];
    _checkSoldierLabel.textAlignment = NSTextAlignmentCenter;
    _checkSoldierLabel.layer.borderWidth = 1.0;
    [attView addSubview:_checkSoldierLabel];
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(106), H(175), W(73), H(27))];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    confirmBtn.layer.borderWidth = 1.0;
    [confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [attView addSubview:confirmBtn];
}
//出战士兵数改变
-(void)sliderChanged:(UISlider *)slider
{
    _checkSoldierLabel.text = [NSString stringWithFormat:@"出战的士兵数:%.f",slider.value];
}

//出战武将选择
-(void)checkGeneral
{
    //将flag标记为1
    flag = 1;
    
    CheckGeneralTableViewController *checkGeneralController = [[CheckGeneralTableViewController alloc]initWithSave:self.save];
    checkGeneralController.delegate = self;
    KKNavigationController *kkController = [[KKNavigationController alloc]initWithRootViewController:checkGeneralController];
    [self presentViewController:kkController animated:YES completion:^{
        
    }];

}

//代理传值
-(void)passValue:(GeneralModel *)general
{
    if (flag == 1)//1为选择的是出战武将
    {
        self.checkedGeneral = general;
        self.generalLabel.text = [NSString stringWithFormat:@"出战武将:%@",self.checkedGeneral.name];
        self.soldierSlide.maximumValue = MIN([self.save.characterModel.soldierNum intValue], [self.checkedGeneral.maxSoldiers intValue]);
    }
    else if (flag == 2)//2为选择的是驻守武将
    {
        for (GeneralModel *tmp in self.save.characterModel.carryingGeneral) {
            if ([tmp.generalId isEqualToString:general.generalId]) {
                [self.save.characterModel.carryingGeneral removeObject:tmp];
                self.residenceGeneralLabel.text = [NSString stringWithFormat:@"驻守武将:%@",tmp.name];
                self.city.residenceGeneral = tmp.name;
            }
        }
        if (!general) {
            self.residenceGeneralLabel.text = @"未驻守";
        }
    }
    
    //flag还原为0
    flag = 0;
}

//出战确认
-(void)confirm:(UIButton *)button
{
    [self dismissViewControllerAnimated:NO completion:^{
        [self.delegate cityEventDelegatePassSave:self.save withCity:self.city withGeneral:self.checkedGeneral withSoldierNum:[NSNumber numberWithInt:(int)self.soldierSlide.value]];
    }];
}

/**
 *  没钱交过路费
 */
-(void)noMoney
{
    //创建视图并设定背景图片
    UIView *noMoneyView = [[UIView alloc]initWithFrame:CGRectMake(W(0), H(0), W(294), H(225))];
    noMoneyView.center = CGPointMake(WinWidth/2, WinHeight/2);
    noMoneyView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:noMoneyView];
    
    UIImageView *BG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    BG.image = [ImageClip imageWithJpgName:@"messageBG"];
    [noMoneyView addSubview:BG];
    UIImageView *border = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    border.image = [ImageClip imageWithPngName:@"messageBorder1"];
    [noMoneyView addSubview:border];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(W(24), H(30), W(125), H(125))];
    imageView.image = [ImageClip imageWithPngName:@"flaticon_60"];
    [noMoneyView addSubview:imageView];
    //详细情况
    UILabel *descrptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(170), H(34), W(105), H(70))];
    descrptionLabel.text = @"由于身上的钱不够交过路费，被一顿殴打！!\n扣掉10血";
    descrptionLabel.numberOfLines = 0;
    descrptionLabel.layer.borderWidth = 1.0;
    [noMoneyView addSubview:descrptionLabel];
    
    //剩余血量
    int blood;
    if ([self.save.characterModel.currentBlood intValue]>10) {
        blood = [self.save.characterModel.currentBlood intValue]-10;
    }
    else
    {
        blood = 0;
    }
    self.save.characterModel.currentBlood = [NSNumber numberWithInt:blood];
    UILabel *bloodLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(170), H(120), W(105), H(43))];
    bloodLabel.text = [NSString stringWithFormat:@"剩余血量:%i",[self.save.characterModel.currentBlood intValue]];
    bloodLabel.textAlignment = NSTextAlignmentCenter;
    bloodLabel.layer.borderWidth = 1.0;
    [noMoneyView addSubview:bloodLabel];
    //确定按钮
    UIButton *confirmNoMoney = [[UIButton alloc]initWithFrame:CGRectMake(W(101), H(180), W(111), H(37))];
    [confirmNoMoney setTitle:@"确认" forState:UIControlStateNormal];
    [confirmNoMoney setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmNoMoney addTarget:self action:@selector(confirmMoney) forControlEvents:UIControlEventTouchUpInside];
    [noMoneyView addSubview:confirmNoMoney];
    
}

/**
 *  确认掉血
 */
-(void)confirmMoney
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

//交过路费
-(void)giveRoadToll:(UIButton *)button
{
    [button.superview removeFromSuperview];
    if ([self.save.characterModel.money intValue]<[self.city.roadToll intValue]) {
        self.save.characterModel.money = @0;
        [self noMoney];
    }else{
        //创建视图并设定背景图片
        UIView *roadTollView = [[UIView alloc]initWithFrame:CGRectMake(W(0), H(0), W(294), H(225))];
        roadTollView.center = CGPointMake(WinWidth/2, WinHeight/2);
        roadTollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:roadTollView];
        
        UIImageView *BG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
        BG.image = [ImageClip imageWithJpgName:@"messageBG"];
        [roadTollView addSubview:BG];
        UIImageView *border = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
        border.image = [ImageClip imageWithPngName:@"messageBorder1"];
        [roadTollView addSubview:border];
        
        //标题label
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(37), H(40), W(220), H(32))];
        titleLabel.text = @"交纳过路费";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.layer.borderWidth = 1.0;
        [roadTollView addSubview:titleLabel];
        
        //已交纳数额
        
        UILabel *reduceMoney = [[UILabel alloc]initWithFrame:CGRectMake(W(20), H(107), W(104), H(32))];
        if ([self.save.characterModel.money intValue]<[self.city.roadToll intValue]) {
            roadTollnumber = [self.save.characterModel.money intValue];
        }
        else
        {
            roadTollnumber = [self.city.roadToll intValue];
        }
        reduceMoney.text = [NSString stringWithFormat:@"已交纳:%i",roadTollnumber];
        reduceMoney.textAlignment = NSTextAlignmentCenter;
        reduceMoney.layer.borderWidth = 1.0;
        [roadTollView addSubview:reduceMoney];
        
        //剩余金钱
        
        UILabel *remainingMoney = [[UILabel alloc]initWithFrame:CGRectMake(W(176), H(107), W(104), H(32))];
        remainingMoney.text = [NSString stringWithFormat:@"剩余：%i",([self.save.characterModel.money intValue]-roadTollnumber)];
        remainingMoney.textAlignment = NSTextAlignmentCenter;
        remainingMoney.layer.borderWidth = 1.0;
        [roadTollView addSubview:remainingMoney];
        
        //确定按钮
        
        UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(99), H(159), W(97), H(32))];
        [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        confirmBtn.layer.borderWidth = 1.0;
        [confirmBtn addTarget:self action:@selector(confirmRoadToll:) forControlEvents:UIControlEventTouchUpInside];
        [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [roadTollView addSubview:confirmBtn];
    }
    
}
/**
 *  确认交纳过路费
 */
-(void)confirmRoadToll:(UIButton *)btn
{
    NSNumber *remain = [NSNumber numberWithInt:([self.save.characterModel.money intValue]-roadTollnumber)];
    self.save.characterModel.money = remain;
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

@end
