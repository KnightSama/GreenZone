//
//  CityMsgTableViewController.m
//  GreenZone
//
//  Created by niit on 15-7-6.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "CityMsgTableViewController.h"
#import "Save.h"
#import "CityModel.h"
#import "ImageClip.h"
#import "AudioTool.h"
@interface CityMsgTableViewController (){
    int costMoney;
}

@end

@implementation CityMsgTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cities = self.save.characterModel.havingCities;
    self.title = @"拥有的城市";
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(gotoBack)];
    self.navigationItem.leftBarButtonItem = left;
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
 *  返回上一页
 */
-(void)gotoBack
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

/**
 *   根据存档初始化
 */
-(instancetype)initWithSave:(Save *)save
{
    if (self = [super init])
    {
        self.save = save;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //创建cell并添加各种控件
    static NSString *identifier = @"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, W(320), H(284))];
    }
    CityModel *city = (CityModel *)self.cities[indexPath.row];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WinWidth, H(284))];
    backImage.image = [ImageClip imageWithPngName:@"Castle3"];
    backImage.alpha = 0.5;
    backImage.layer.borderWidth = 2.0;
    [cell addSubview:backImage];
    //城市名字label
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(8), H(8), W(304), H(33))];
    nameLabel.text = city.name;
    nameLabel.layer.borderWidth = 1.0;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:nameLabel];
    
    //攻击力
    UILabel *attackLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(50), H(0), W(86), H(33))];
    attackLabel.text = [NSString stringWithFormat:@"%li",[city.attack integerValue]];
    attackLabel.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *attackImageView = [[UIImageView alloc]init];
    attackImageView.image = [ImageClip imageWithPngName:@"icon07"];
    attackImageView.frame = CGRectMake(W(0), H(0), W(33), H(33));
    UIView *attackView = [[UIView alloc]initWithFrame:CGRectMake(W(8), H(49), W(136), H(33))];
    attackView.layer.borderWidth = 1.0;
    [cell addSubview:attackView];
    [attackView addSubview:attackImageView];
    [attackView addSubview:attackLabel];
    
    
    //防御力label
    UILabel *defenceLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(50), H(0), W(86), H(33))];
    defenceLabel.text = [NSString stringWithFormat:@"%li",[city.defence integerValue]];
    defenceLabel.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *defenceimageView = [[UIImageView alloc]init];
    defenceimageView.image = [ImageClip imageWithPngName:@"icon01"];
    defenceimageView.frame = CGRectMake(W(0), H(0), W(33), H(33));
    UIView *defenceView = [[UIView alloc]initWithFrame:CGRectMake(W(169), H(49), W(136), H(33))];
    defenceView.layer.borderWidth = 1.0;
    
    [cell addSubview:defenceView];
    [defenceView addSubview:defenceLabel];
    [defenceView addSubview:defenceimageView];
    
    
    //驻守武将label
    UILabel *residenceGeneralLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(50), H(0), W(86), H(33))];
    residenceGeneralLabel.text = city.residenceGeneral;
    if ([city.residenceGeneral isEqualToString:@""])
    {
        residenceGeneralLabel.text = @"没有驻守";
    }
    residenceGeneralLabel.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *residenceGeneralImageView = [[UIImageView alloc]init];
    residenceGeneralImageView.image = [ImageClip imageWithPngName:@"icon76"];
    residenceGeneralImageView.frame = CGRectMake(W(0), H(0), W(33), H(33));
    UIView *residenceGeneralView = [[UIView alloc]initWithFrame:CGRectMake(W(8), H(90), W(136), H(33))];
    residenceGeneralView.layer.borderWidth = 1.0;
    [cell addSubview:residenceGeneralView];
    [residenceGeneralView addSubview:residenceGeneralLabel];
    [residenceGeneralView addSubview:residenceGeneralImageView];
    
    
    //驻守士兵
    UILabel *residenceSoldierLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(50), H(0), W(86), H(33))];
    residenceSoldierLabel.text = [NSString stringWithFormat:@"%li",[city.residenceSoldiers integerValue]];
    residenceSoldierLabel.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *residenceSoldierImageView = [[UIImageView alloc]init];
    residenceSoldierImageView.image = [ImageClip imageWithPngName:@"icon80b"];
    residenceSoldierImageView.frame = CGRectMake(W(0), H(0), W(33), H(33));
    UIView *residenceSoldierView = [[UIView alloc]initWithFrame:CGRectMake(W(169), H(90), W(136), H(33))];
    residenceSoldierView.layer.borderWidth = 1.0;
    [cell addSubview:residenceSoldierView];
    [residenceSoldierView addSubview:residenceSoldierImageView];
    [residenceSoldierView addSubview:residenceSoldierLabel];
    
    
    //主角在该城市威望
    UILabel *manaLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(50), H(0), W(86), H(33))];
    manaLabel.text = [NSString stringWithFormat:@"%li",[city.mana integerValue]];
    manaLabel.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *manaImageView = [[UIImageView alloc]init];
    manaImageView.image = [ImageClip imageWithPngName:@"icon47"];
    manaImageView.frame = CGRectMake(W(0), H(0), W(33), H(33));
    UIView *manaView = [[UIView alloc]initWithFrame:CGRectMake(W(8), H(131), W(136), H(33))];
    manaView.layer.borderWidth = 1.0;
    [cell addSubview:manaView];
    [manaView addSubview:manaImageView];
    [manaView addSubview:manaLabel];
    
    
    //城市税收
    UILabel *taxLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(50), H(0), W(86), H(33))];
    NSInteger tax = [[city.output valueForKey:@"number"] integerValue];
    taxLabel.text = [NSString stringWithFormat:@"%li",tax];
    taxLabel.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *taxImageView = [[UIImageView alloc]init];
    taxImageView.image = [ImageClip imageWithPngName:@"icon10"];
    taxImageView.frame = CGRectMake(W(0), H(0), W(33), H(33));
    UIView *taxView = [[UIView alloc]initWithFrame:CGRectMake(W(169), H(131), W(136), H(33))];
    taxView.layer.borderWidth = 1.0;
    [cell addSubview:taxView];
    [taxView addSubview:taxLabel];
    [taxView addSubview:taxImageView];
    
    //城市介绍
    UITextView *cityDescription = [[UITextView alloc]initWithFrame:CGRectMake(W(8), H(172), W(299), H(54))];
    cityDescription.text = city.cityDescription;
    cityDescription.layer.borderWidth = 1.0;
    cityDescription.editable = NO;
    cityDescription.backgroundColor = [UIColor clearColor];
    [cell addSubview:cityDescription];
    
    //城市工程建设
    UIButton *manaBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(8), H(234), W(72), H(33))];
    manaBtn.layer.borderWidth = 1.0;
    manaBtn.tag = indexPath.row;
    [manaBtn setTitle:@"工程建设" forState:UIControlStateNormal];
    [manaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [manaBtn addTarget:self action:@selector(addMana:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:manaBtn];
    
    //城市军事建设
    UIButton *militaryBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(84), H(234), W(72), H(33))];
    militaryBtn.layer.borderWidth = 1.0;
    militaryBtn.tag = indexPath.row;
    [militaryBtn setTitle:@"军事建设" forState:UIControlStateNormal];
    [militaryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [militaryBtn addTarget:self action:@selector(addMilitary:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:militaryBtn];
    
    //城市人口建设
    UIButton *soldierBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(160), H(234), W(72), H(33))];
    soldierBtn.layer.borderWidth = 1.0;
    soldierBtn.tag = indexPath.row;
    [soldierBtn setTitle:@"人口建设" forState:UIControlStateNormal];
    [soldierBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [soldierBtn addTarget:self action:@selector(addSoldier:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:soldierBtn];
    
    //城市税收
    UIButton *taxBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(235), H(234), W(72), H(33))];
    taxBtn.layer.borderWidth = 1.0;
    taxBtn.tag = indexPath.row;
    [taxBtn setTitle:@"城市税收" forState:UIControlStateNormal];
    [taxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [taxBtn addTarget:self action:@selector(addTax:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:taxBtn];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return H(284);
}

/**
 *  城市税收
 */
-(void)addTax:(UIButton *)btn
{
    self.tableView.scrollEnabled = NO;
    CityModel *city = self.cities[btn.tag];
    self.city = city;
    //创建view显示在窗口上
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    view.center = CGPointMake(WinWidth/2, WinHeight/2);
    self.showView = view;
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
    nameLabel.text = [NSString stringWithFormat:@"向%@市民征税",city.name];
    [view addSubview:nameLabel];
    //创建税收标签
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(31), H(92), W(104), H(27))];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.text = [NSString stringWithFormat:@"税收:%@",[city.output valueForKey:@"number"]];
    self.moneyLabel = moneyLabel;
    [view addSubview:moneyLabel];
    //创建城市威望
    UILabel *manaLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(160), H(92), W(104), H(27))];
    manaLabel.textAlignment = NSTextAlignmentCenter;
    manaLabel.text = [NSString stringWithFormat:@"威望:%@",city.mana];
    self.manaLabel = manaLabel;
    [view addSubview:manaLabel];
    //创建税收滑条
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(W(19), H(127), W(257), H(31))];
    slider.minimumValue = 0;
    slider.maximumValue = [[city.output valueForKey:@"number"] integerValue]+[city.mana integerValue]/2;
    slider.value = [[city.output valueForKey:@"number"] integerValue];
    [slider addTarget:self action:@selector(changeMoneyNumber:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:slider];
    //创建确定按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(W(111), H(165), W(73), H(27))];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 1.0;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}

/**
 *  改变税收值
 */
-(void)changeMoneyNumber:(UISlider *)slider{
    int oldMoney = [[self.city.output valueForKey:@"number"] intValue];
    int money = slider.value;
    int mana = [self.city.mana intValue];
    int delta = money - oldMoney;
    if (delta>0) {
        self.city.mana = [NSNumber numberWithInt:mana-delta];
    }
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:self.city.output];
    [tmpDict setObject:[NSNumber numberWithInt:(oldMoney+delta)] forKey:@"number"];
    self.city.output = tmpDict;
    self.moneyLabel.text = [NSString stringWithFormat:@"税收:%@",[self.city.output valueForKey:@"number"]];
    self.manaLabel.text = [NSString stringWithFormat:@"威望:%@",self.city.mana];
}

/**
 *  返回
 */
-(void)cancel{
    self.tableView.scrollEnabled = YES;
    [self.showView removeFromSuperview];
    [self.tableView reloadData];
}


/**
 *  城市人口建设
 */
-(void)addSoldier:(UIButton *)btn
{
    self.tableView.scrollEnabled = NO;
    CityModel *city = self.cities[btn.tag];
    self.city = city;
    //创建view显示在窗口上
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    view.center = CGPointMake(WinWidth/2, WinHeight/2);
    self.showView = view;
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
    nameLabel.text = [NSString stringWithFormat:@"对城市进行人口建设"];
    [view addSubview:nameLabel];
    //创建投资标签
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(76), H(92), W(142), H(27))];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.text = [NSString stringWithFormat:@"要花费多少钱:%@",@0];
    self.moneyLabel = moneyLabel;
    [view addSubview:moneyLabel];
    //创建投资滑条
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(W(19), H(127), W(257), H(31))];
    slider.minimumValue = 0;
    slider.maximumValue = [self.save.characterModel.money intValue];
    slider.value = 0;
    [slider addTarget:self action:@selector(soldierMoneyNumber:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:slider];
    //创建确定按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(W(111), H(165), W(73), H(27))];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 1.0;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancel2) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}

/**
 *  士兵投资方法
 */
-(void)soldierMoneyNumber:(UISlider *)slider{
    int money = slider.value;
    self.moneyLabel.text = [NSString stringWithFormat:@"要花费多少钱:%i",money];
    costMoney = money;
}

/**
 *  返回
 */
-(void)cancel2{
    [self.showView removeFromSuperview];
    //创建view显示在窗口上
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    view.center = CGPointMake(WinWidth/2, WinHeight/2);
    self.showView = view;
    [self.view addSubview:view];
    //创建背景图
    UIImageView *imageBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    imageBack.image = [ImageClip imageWithJpgName:@"messageBG"];
    [view addSubview:imageBack];
    //创建背景边框
    UIImageView *imageBorder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    imageBorder.image = [ImageClip imageWithPngName:@"messageBorder1"];
    [view addSubview:imageBorder];
    //创建消息View
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(W(31), H(50), W(233), H(138))];
    textView.editable = NO;
    textView.backgroundColor = [UIColor clearColor];
    if (costMoney>=500) {
        textView.text = [NSString stringWithFormat:@"你花费了 %i 钱币来进行城市人口建设,城市的驻守士兵增加了",costMoney];
    }else{
        textView.text = [NSString stringWithFormat:@"你花费了 %i 钱币来进行城市人口建设,但好像并没有发生什么",costMoney];
    }
    textView.font = [UIFont systemFontOfSize:20];
    [view addSubview:textView];
    //创建确定按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(W(111), H(165), W(73), H(27))];
    button.layer.borderWidth = 1.0;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    self.save.characterModel.money = [NSNumber numberWithInt:([self.save.characterModel.money intValue] - costMoney)];
    self.city.residenceSoldiers = [NSNumber numberWithInt:([self.city.residenceSoldiers intValue]+costMoney/500)];
}

/**
 *  返回
 */
-(void)back{
    self.tableView.scrollEnabled = YES;
    [self.showView removeFromSuperview];
    [self.tableView reloadData];
}

/**
 *  城市军事建设
 */
-(void)addMilitary:(UIButton *)btn
{
    self.tableView.scrollEnabled = NO;
    CityModel *city = self.cities[btn.tag];
    self.city = city;
    //创建view显示在窗口上
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    view.center = CGPointMake(WinWidth/2, WinHeight/2);
    self.showView = view;
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
    nameLabel.text = [NSString stringWithFormat:@"对城市进行军事投资"];
    [view addSubview:nameLabel];
    //创建投资标签
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(76), H(92), W(142), H(27))];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.text = [NSString stringWithFormat:@"要花费多少钱:%@",@0];
    self.moneyLabel = moneyLabel;
    [view addSubview:moneyLabel];
    //创建投资滑条
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(W(19), H(127), W(257), H(31))];
    slider.minimumValue = 0;
    slider.maximumValue = [self.save.characterModel.money intValue];
    slider.value = 0;
    [slider addTarget:self action:@selector(MilitaryMoneyNumber:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:slider];
    //创建确定按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(W(111), H(165), W(73), H(27))];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 1.0;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancel3) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}

/**
 *  军事投资方法
 */
-(void)MilitaryMoneyNumber:(UISlider *)slider{
    int money = slider.value;
    self.moneyLabel.text = [NSString stringWithFormat:@"要花费多少钱:%i",money];
    costMoney = money;
}

/**
 *  返回
 */
-(void)cancel3{
    self.save.characterModel.money = [NSNumber numberWithInt:([self.save.characterModel.money intValue] - costMoney)];
    self.city.attack = [NSNumber numberWithInt:([self.city.attack intValue]+costMoney/1000)];
    self.city.defence = [NSNumber numberWithInt:([self.city.defence intValue]+costMoney/2000)];
    [self.showView removeFromSuperview];
    //创建view显示在窗口上
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    view.center = CGPointMake(WinWidth/2, WinHeight/2);
    self.showView = view;
    [self.view addSubview:view];
    //创建背景图
    UIImageView *imageBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    imageBack.image = [ImageClip imageWithJpgName:@"messageBG"];
    [view addSubview:imageBack];
    //创建背景边框
    UIImageView *imageBorder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    imageBorder.image = [ImageClip imageWithPngName:@"messageBorder1"];
    [view addSubview:imageBorder];
    //创建消息View
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(W(31), H(50), W(233), H(138))];
    textView.editable = NO;
    textView.backgroundColor = [UIColor clearColor];
    if (costMoney>=1000) {
        textView.text = [NSString stringWithFormat:@"你花费了 %i 钱币来进行城市军事建设,城市的攻击与防御都有所提高",costMoney];
    }else{
        textView.text = [NSString stringWithFormat:@"你花费了 %i 钱币来进行城市军事建设,但好像并没有什么用",costMoney];
    }
    textView.font = [UIFont systemFontOfSize:20];
    [view addSubview:textView];
    //创建确定按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(W(111), H(165), W(73), H(27))];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 1.0;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}

/**
 *  城市工程建设
 */
-(void)addMana:(UIButton *)btn
{
    self.tableView.scrollEnabled = NO;
    CityModel *city = self.cities[btn.tag];
    self.city = city;
    //创建view显示在窗口上
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    view.center = CGPointMake(WinWidth/2, WinHeight/2);
    self.showView = view;
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
    nameLabel.text = [NSString stringWithFormat:@"对城市进行工程建设"];
    [view addSubview:nameLabel];
    //创建投资标签
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(76), H(92), W(142), H(27))];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.text = [NSString stringWithFormat:@"要花费多少钱:%@",@0];
    self.moneyLabel = moneyLabel;
    [view addSubview:moneyLabel];
    //创建投资滑条
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(W(19), H(127), W(257), H(31))];
    slider.minimumValue = 0;
    slider.maximumValue = [self.save.characterModel.money integerValue];
    slider.value = 0;
    [slider addTarget:self action:@selector(manaMoneyNumber:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:slider];
    //创建确定按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(W(111), H(165), W(73), H(27))];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 1.0;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancel4) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}

/**
 *  工程投资方法
 */
-(void)manaMoneyNumber:(UISlider *)slider{
    int money = slider.value;
    self.moneyLabel.text = [NSString stringWithFormat:@"要花费多少钱:%i",money];
    costMoney = money;
}

/**
 *  返回
 */
-(void)cancel4{
    self.save.characterModel.money = [NSNumber numberWithInt:([self.save.characterModel.money intValue] - costMoney)];
    self.city.mana = [NSNumber numberWithInt:([self.city.mana intValue]+costMoney/2000)];
    [self.showView removeFromSuperview];
    //创建view显示在窗口上
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    view.center = CGPointMake(WinWidth/2, WinHeight/2);
    self.showView = view;
    [self.view addSubview:view];
    //创建背景图
    UIImageView *imageBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    imageBack.image = [ImageClip imageWithJpgName:@"messageBG"];
    [view addSubview:imageBack];
    //创建背景边框
    UIImageView *imageBorder = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(294), H(225))];
    imageBorder.image = [ImageClip imageWithPngName:@"messageBorder1"];
    [view addSubview:imageBorder];
    //创建消息View
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(W(31), H(50), W(233), H(138))];
    textView.editable = NO;
    textView.backgroundColor = [UIColor clearColor];
    if (costMoney>=2000) {
        textView.text = [NSString stringWithFormat:@"你花费了 %i 钱币来进行城市工程建设,你在该城市的威望值增加了",costMoney];
    }else{
        textView.text = [NSString stringWithFormat:@"你花费了 %i 钱币来进行城市工程建设,但好像并没有什么用",costMoney];
    }
    textView.font = [UIFont systemFontOfSize:20];
    [view addSubview:textView];
    //创建确定按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(W(111), H(165), W(73), H(27))];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 1.0;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}



@end
