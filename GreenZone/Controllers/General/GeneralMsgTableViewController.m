//
//  GeneralMsgTableViewController.m
//  GreenZone
//
//  Created by student on 15-7-6.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "GeneralMsgTableViewController.h"
#import "Save.h"
#import "ImageClip.h"
#import "GeneralModel.h"
#import "CityModel.h"
#import "AudioTool.h"

@interface GeneralMsgTableViewController (){
    int costMoney;
    GeneralModel *oneGeneral;
    UIView *activeView;
    UILabel *activeLabel;
}

@end

@implementation GeneralMsgTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.generals = self.save.characterModel.allGeneral;
    self.title = @"武将信息";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(gotoBack)];
    self.navigationItem.leftBarButtonItem = item;
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.generals.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WinWidth, H(250))];
	backImage.image = [ImageClip imageWithPngName:@"CrossedSwords"];
	backImage.alpha = 0.5;
	backImage.layer.borderWidth = 2.0;
	[cell addSubview:backImage];
    
    oneGeneral = self.generals[indexPath.row];
    
    //添加头像
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(W(8), H(8), W(96), H(96))];
    imageView.image = [ImageClip imageWithFaceImage:oneGeneral.image getByLocation:@0];
	imageView.layer.borderWidth = 1.0;
    [cell addSubview:imageView];
    //添加姓名
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(117), H(8), W(187), H(33))];
    nameLabel.text = oneGeneral.name;
    nameLabel.layer.borderWidth = 1.0;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:nameLabel];
    //添加攻击力
    UIView *atkView = [[UIView alloc]initWithFrame:CGRectMake(W(117), H(42), W(91), H(33))];
    atkView.layer.borderWidth = 1.0;
    [cell addSubview:atkView];
    UIImageView *atkImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, W(33), H(33))];
    atkImageView.image = [ImageClip imageWithPngName:@"icon07"];
    [atkView addSubview:atkImageView];
    UILabel *atkLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(33), 0, W(91)-W(33), H(33))];
    atkLabel.text = [NSString stringWithFormat:@"%@",oneGeneral.attack];
    atkLabel.textAlignment = NSTextAlignmentCenter;
    [atkView addSubview:atkLabel];
    //添加防御力
    UIView *defView = [[UIView alloc]initWithFrame:CGRectMake(W(213), H(42), W(91), H(33))];
    defView.layer.borderWidth = 1.0;
    [cell addSubview:defView];
    UIImageView *defImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, W(33), H(33))];
    defImageView.image = [ImageClip imageWithPngName:@"icon01"];
    [defView addSubview:defImageView];
    UILabel *defLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(33), 0, W(91)-W(33), H(33))];
    defLabel.text = [NSString stringWithFormat:@"%@",oneGeneral.defence];
    defLabel.textAlignment = NSTextAlignmentCenter;
    [defView addSubview:defLabel];
    //添加忠诚度
    UIView *loyaltyView = [[UIView alloc]initWithFrame:CGRectMake(W(117), H(77), W(91), H(33))];
    loyaltyView.layer.borderWidth = 1.0;
    [cell addSubview:loyaltyView];
    UIImageView *loyaltyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(33), H(33))];
    loyaltyImageView.image = [ImageClip imageWithPngName:@"icon18"];
    [loyaltyView addSubview:loyaltyImageView];
    UILabel *loyaltyLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(33), 0, W(91)-W(33), H(33))];
    loyaltyLabel.text =[NSString stringWithFormat:@"%@",oneGeneral.loyalty];
    loyaltyLabel.textAlignment = NSTextAlignmentCenter;
    [loyaltyView addSubview:loyaltyLabel];
    //添加带兵数
    UIView *maxSoldiersView = [[UIView alloc]initWithFrame:CGRectMake(W(213), H(77), W(91), H(33))];
    maxSoldiersView.layer.borderWidth = 1.0;
    [cell addSubview:maxSoldiersView];
    UIImageView *maxSoldiersImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(33), H(33))];
    maxSoldiersImageView.image = [ImageClip imageWithPngName:@"icon80b"];
    [maxSoldiersView addSubview:maxSoldiersImageView];
    UILabel *maxSoldiersLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(33), 0, W(91)-W(33), H(33))];
    maxSoldiersLabel.text =[NSString stringWithFormat:@"%@",oneGeneral.maxSoldiers];
    maxSoldiersLabel.textAlignment = NSTextAlignmentCenter;
    [maxSoldiersView addSubview:maxSoldiersLabel];
    //添加体力值
    activeView = [[UIView alloc]initWithFrame:CGRectMake(W(10), H(113), W(0), H(33))];
    [cell addSubview:activeView];
     activeLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(10), H(113), W(294), H(33))];
    [cell addSubview:activeLabel];
    [self reloadPowerView];
    //添加描述
    UITextView *descriptionTextView = [[UITextView alloc]initWithFrame:CGRectMake(W(10), H(147), W(294), H(48))];
    descriptionTextView.text = oneGeneral.generalDescription;
    descriptionTextView.editable = NO;
    descriptionTextView.layer.borderWidth = 1.0;
	descriptionTextView.backgroundColor = [UIColor clearColor];
    [cell addSubview:descriptionTextView];
    //添加训练按钮(提高攻防)
    UIButton *trainBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(10), H(203), W(88), H(33))];
//    trainBtn.backgroundColor = [UIColor redColor];
	trainBtn.layer.borderWidth = 1.0;
    trainBtn.layer.cornerRadius = 5;
    trainBtn.tag = indexPath.row;
    [trainBtn setTitle:@"训练" forState:UIControlStateNormal];
    [trainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [trainBtn addTarget:self action:@selector(trainBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:trainBtn];
    //添加抚恤按钮(提高忠诚)
    UIButton *careBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(113), H(203), W(88), H(33))];
//    careBtn.backgroundColor = [UIColor redColor];
	careBtn.layer.borderWidth = 1.0;
    careBtn.layer.cornerRadius = 5;
    careBtn.tag = indexPath.row;
    [careBtn setTitle:@"抚恤" forState:UIControlStateNormal];
    [careBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [careBtn addTarget:self action:@selector(careBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:careBtn];
    //添加解雇按钮
    UIButton *fireBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(216), H(203), W(88), H(33))];
//    fireBtn.backgroundColor = [UIColor redColor];
	fireBtn.layer.borderWidth = 1.0;
    fireBtn.layer.cornerRadius = 5;
    fireBtn.tag = indexPath.row;
    [fireBtn setTitle:@"解雇" forState:UIControlStateNormal];
    [fireBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fireBtn addTarget:self action:@selector(fireBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:fireBtn];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return H(250);
}


/**
 *  刷新武将体力值
 */
-(void)reloadPowerView{
    CGFloat scale = [oneGeneral.power doubleValue]/100;
    CGFloat width = scale * W(294);
    [UIView animateWithDuration:2.0 animations:^{
        activeView.frame = CGRectMake(W(10), H(113), width, H(33));
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
    activeLabel.textAlignment = NSTextAlignmentCenter;
    activeLabel.layer.borderWidth = 1.0;
    activeLabel.text = [NSString stringWithFormat:@"体力值:%.0f%@",[oneGeneral.power doubleValue],@"%"];
}


/**
 *  训练(提高攻防)
 */
-(void)trainBtnPressed:(UIButton *)btn{
    self.tableView.scrollEnabled = NO;
    GeneralModel *general = self.generals[btn.tag];
    self.general = general;
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
    nameLabel.text = [NSString stringWithFormat:@"训练该武将"];
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
    [slider addTarget:self action:@selector(trainMoneyNumber:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:slider];
    //创建确定按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(W(111), H(165), W(73), H(27))];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 1.0;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancel1) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
 }

/**
 *  训练投资方法
 */
-(void)trainMoneyNumber:(UISlider *)slider{
    int money = slider.value;
    self.moneyLabel.text = [NSString stringWithFormat:@"要花费多少钱:%i",money];
    costMoney = money;
}

/**
 *  返回1
 */
-(void)cancel1{
    self.save.characterModel.money = [NSNumber numberWithInt:([self.save.characterModel.money intValue] - costMoney)];
    self.general.attack = [NSNumber numberWithInt:([self.general.attack intValue]+costMoney/500)];
    self.general.defence = [NSNumber numberWithInt:([self.general.attack intValue]+costMoney/1000)];
    self.general.maxSoldiers = [NSNumber numberWithInt:([self.general.maxSoldiers intValue]+costMoney/2000)];
    self.general.loyalty = [NSNumber numberWithInt:([self.general.loyalty intValue]-costMoney/500)];
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
    if (costMoney>500) {
        textView.text = [NSString stringWithFormat:@"你花费了 %i 钱币来训练武将,你的武将属性有所增加,但是忠诚度有所减少",costMoney];
    }else{
        textView.text = [NSString stringWithFormat:@"你花费了 %i 钱币来训练武将,但好像没有发生什么",costMoney];
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
 *  返回
 */
-(void)back{
    self.tableView.scrollEnabled = YES;
    [self.showView removeFromSuperview];
    [self.tableView reloadData];
}


/**
 *  抚恤(提高忠诚)
 */
-(void)careBtnPressed:(UIButton *)btn{
    self.tableView.scrollEnabled = NO;
    GeneralModel *general = self.generals[btn.tag];
    self.general = general;
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
    nameLabel.text = [NSString stringWithFormat:@"奖赏该武将"];
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
    [slider addTarget:self action:@selector(careMoneyNumber:) forControlEvents:UIControlEventValueChanged];
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
 *  奖赏投资方法
 */
-(void)careMoneyNumber:(UISlider *)slider{
    int money = slider.value;
    self.moneyLabel.text = [NSString stringWithFormat:@"要花费多少钱:%i",money];
    costMoney = money;
}

/**
 *  返回2
 */
-(void)cancel2{
    self.save.characterModel.money = [NSNumber numberWithInt:([self.save.characterModel.money intValue] - costMoney)];
    self.general.loyalty = [NSNumber numberWithInt:([self.general.loyalty intValue]+costMoney/500)];
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
    if (costMoney>500) {
        textView.text = [NSString stringWithFormat:@"你花费了 %i 钱币来奖赏武将,你的武将忠诚度提升了",costMoney];
    }else{
        textView.text = [NSString stringWithFormat:@"你花费了 %i 钱币来奖赏武将,但好像没有发生什么",costMoney];
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
 *  解雇
 */
-(void)fireBtnPressed:(UIButton *)btn{
    self.tableView.scrollEnabled = NO;
    GeneralModel *general = self.generals[btn.tag];
    self.general = general;
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
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(46), H(49), W(198), H(27))];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = [NSString stringWithFormat:@"确定要解雇这个武将吗"];
    [view addSubview:nameLabel];
    //创建确定按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(W(46), H(109), W(84), H(27))];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 1.0;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back2) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    //创建取消按钮
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(W(160), H(109), W(84), H(27))];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.layer.borderWidth = 1.0;
    [button2 setTitle:@"取消" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button2];
}

/**
 *  返回
 */
-(void)back2{
    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:self.generals];
    //从携带武将中移除
    for (GeneralModel *general in tmpArr) {
        if ([general.generalId isEqualToString:self.general.generalId]) {
            [tmpArr removeObject:general];
            break;
        }
    }
    self.generals = [NSArray arrayWithArray:tmpArr];
    self.save.characterModel.carryingGeneral = [NSMutableArray arrayWithArray:tmpArr];
    //从所有武将中删除
    tmpArr = [NSMutableArray arrayWithArray:self.save.characterModel.allGeneral];
    [tmpArr removeObject:self.general];
    self.save.characterModel.allGeneral = tmpArr;
    //若驻守则从城市列表中移除
    for (CityModel *city in self.save.characterModel.havingCities) {
        if ([city.residenceGeneral isEqualToString:self.general.name]) {
            city.residenceGeneral = @"";
            break;
        }
    }
    //添加回剩余武将列表
    tmpArr = [NSMutableArray arrayWithArray:self.save.generalArr];
    [tmpArr addObject:self.general];
    self.save.generalArr = tmpArr;
    self.tableView.scrollEnabled = YES;
    [self.showView removeFromSuperview];
    [self.tableView reloadData];
}


@end
