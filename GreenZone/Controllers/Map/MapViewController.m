//
//  MapViewController.m
//  GreenZone
//
//  Created by zqh on 15/6/30.
//  Copyright (c) 2015年 student. All rights reserved.
//

#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0  //屏幕适配，自动计算不同屏幕对应的x和y方向的坐标
#define H(y) WinHeight*y/568.0

#import "MapViewController.h"
#import "ImageClip.h"
#import "CharacterMove.h"
#import "GeneralModel.h"
#import "ScrollMapView.h"
#import "Map.h"
#import "DiceView.h"
#import "Save.h"
#import "KKNavigationController.h"
#import "SaveGameTableViewController.h"
#import "CharacterMsgViewController.h"
#import "GeneralMsgTableViewController.h"
#import "EventManager.h"
#import "CityMsgTableViewController.h"
#import "AudioTool.h"
#import "CityModel.h"
#import "EventRecorded.h"
#import "HelpViewController.h"
#import "EventTableViewController.h"
#import "EquipmentViewController.h"
#import "RandomEventManager.h"
#import "BattleResultViewController.h"
#import "BattleViewController.h"
#import "BackpackViewController.h"
#import "UsingThingsTBVC.h"
#import "AttackCityBattleViewController.h"

@interface MapViewController ()<DiceViewDelegate,ScrollMapViewDelegate,UIScrollViewDelegate,RandomEventManagerDelegate,BattleViewControllerDelegate,cityEventViewControllerDelegate,AttackCityBattleViewControllerDelegate>

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mapView];
    self.record = [[EventRecorded alloc]init];
    UIApplication *application = [UIApplication sharedApplication];
    application.statusBarHidden = YES;
    [self createWindowUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadHPView];
    [self reloadActiveView];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@",self.gameSave.characterModel.money];
    NSArray *arr = @[@"map1.mp3",@"map2.mp3",@"map3.mp3"];
    self.player = [AudioTool playMusic:arr[arc4random_uniform(3)]];
    self.player.numberOfLoops = NSNotFound;
}

/**
 *  延迟实例化
 */
-(NSArray *)mapEventArr{
    if (!_mapEventArr) {
        _mapEventArr = self.map.mapEventArr;
    }
    return _mapEventArr;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player stop];
}

/**
 *  创建界面
 */
-(void)createWindowUI{
    //创建顶层视图
    [self createUpWindowUI];
    //创建左侧视图
    [self createLeftWindowUI];
    //创建下方视图
    [self createDownWindowUI];
}

/**
 *  创建顶部视图
 */
-(void)createUpWindowUI{
    //创建上方底层View
    self.upView = [[UIView alloc]initWithFrame:CGRectMake(0, -H(80), WinWidth, H(80))];
    //创建背景图
    UIImageView *upBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WinWidth, H(80))];
    upBackImage.image = [ImageClip imageWithPngName:@"bg11"];
    [self.upView addSubview:upBackImage];
    //创建头像框
    self.characterImage = [[UIImageView alloc]initWithFrame:CGRectMake(W(5), H(5), W(70), H(70))];
    self.characterImage.image = [ImageClip circleFaceImageWithName:self.gameSave.characterModel.faceImage borderWidth:1 borderColor:[UIColor clearColor]];
    [self.upView addSubview:self.characterImage];
    //创建血条
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(W(78), H(11), W(234), H(24))];
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, H(24), H(24))];
    imageView1.image = [ImageClip imageWithPngName:@"icon18"];
    UIView *underHpView = [[UIView alloc]initWithFrame:CGRectMake(W(25), H(0), W(209), H(24))];
    underHpView.layer.borderColor = [UIColor blackColor].CGColor;
    underHpView.layer.borderWidth = 1.0;
    self.hpView = [[UIView alloc]initWithFrame:CGRectMake(W(25), H(0), 0, H(24))];
    self.hpLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(25), H(0), W(209), H(24))];
    self.hpLabel.backgroundColor = [UIColor clearColor];
    [view1 addSubview:underHpView];
    [view1 addSubview:self.hpView];
    [view1 addSubview:self.hpLabel];
    [view1 addSubview:imageView1];
    [self.upView addSubview:view1];
    
    //创建行动力
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(W(78), H(43), W(146), H(24))];
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, H(24), H(24))];
    imageView2.image = [ImageClip imageWithPngName:@"icon15"];
    UIView *underActiveView = [[UIView alloc]initWithFrame:CGRectMake(W(25), H(0), W(121), H(24))];
    underActiveView.layer.borderColor = [UIColor blackColor].CGColor;
    underActiveView.layer.borderWidth = 1.0;
    self.activeView = [[UIView alloc]initWithFrame:CGRectMake(W(25), H(0),0, H(24))];
    self.activeLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(25), H(0), W(121), H(24))];
    self.activeLabel.backgroundColor = [UIColor clearColor];
    [view2 addSubview:underActiveView];
    [view2 addSubview:self.activeView];
    [view2 addSubview:self.activeLabel];
    [view2 addSubview:imageView2];
    [self.upView addSubview:view2];
    
    //创建钱币显示视图
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(W(232), H(43), W(80), H(24))];
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, W(24), H(24))];
    imageView3.image = [ImageClip imageWithPngName:@"icon17"];
    self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(25), H(0), W(45), H(24))];
    self.moneyLabel.backgroundColor = [UIColor clearColor];
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@",self.gameSave.characterModel.money];
    [view3 addSubview:self.moneyLabel];
    [view3 addSubview:imageView3];
    [self.upView addSubview:view3];
    
    [self.view addSubview:self.upView];
    //动画显示
    [UIView animateWithDuration:1.0 animations:^{
        self.upView.frame = CGRectMake(0,0, WinWidth, H(80));
    } completion:^(BOOL finished) {
        [self reloadHPView];
        [self reloadActiveView];
    }];
}

/**
 *  创建左边栏视图
 */
-(void)createLeftWindowUI{
    //创建左侧栏视图
    self.leftView = [[UIView alloc]initWithFrame:CGRectMake(-W(120), H(80), W(140), H(300))];
    [self.view addSubview:self.leftView];
    //创建隐藏侧边栏按钮
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(W(0), H(0), W(140), H(20))];
    [btn addTarget:self action:@selector(showOrHideLeftUI) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[ImageClip imageWithPngName:@"bg12"] forState:UIControlStateNormal];
    [self.leftView addSubview:btn];
    //添加查看个人信息按钮
    UIButton *characterBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(5), H(20), W(90), H(50))];
    [characterBtn addTarget:self action:@selector(gotoCharacterMagView) forControlEvents:UIControlEventTouchUpInside];
    [characterBtn setBackgroundImage:[ImageClip imageWithPngName:@"bg13"] forState:UIControlStateNormal];
    [characterBtn setImage:[ImageClip imageWithPngName:@"icon80"] forState:UIControlStateNormal];
    [characterBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 25, 5, 25)];
    [self.leftView addSubview:characterBtn];
    //添加查看城市按钮
    UIButton *cityBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(5), H(70), W(90), H(50))];
    [cityBtn addTarget:self action:@selector(gotoCityMsgView) forControlEvents:UIControlEventTouchUpInside];
    [cityBtn setBackgroundImage:[ImageClip imageWithPngName:@"bg13"] forState:UIControlStateNormal];
    [cityBtn setImage:[ImageClip imageWithPngName:@"icon77"] forState:UIControlStateNormal];
    [cityBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 25, 5, 25)];
    [self.leftView addSubview:cityBtn];
    //添加查看武将按钮
    UIButton *generalBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(5), H(120), W(90), H(50))];
    [generalBtn addTarget:self action:@selector(gotoGeneralMsgView) forControlEvents:UIControlEventTouchUpInside];
    [generalBtn setBackgroundImage:[ImageClip imageWithPngName:@"bg13"] forState:UIControlStateNormal];
    [generalBtn setImage:[ImageClip imageWithPngName:@"icon9"] forState:UIControlStateNormal];
    [generalBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 25, 5, 25)];
    [self.leftView addSubview:generalBtn];
    //添加查看物品按钮
    UIButton *thingBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(5), H(170), W(90), H(50))];
    [thingBtn addTarget:self action:@selector(gotoPackageView) forControlEvents:UIControlEventTouchUpInside];
    [thingBtn setBackgroundImage:[ImageClip imageWithPngName:@"bg13"] forState:UIControlStateNormal];
    [thingBtn setImage:[ImageClip imageWithPngName:@"icon10"] forState:UIControlStateNormal];
    [thingBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 25, 5, 25)];
    [self.leftView addSubview:thingBtn];
    //添加查看任务按钮
    UIButton *taskBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(5), H(220), W(90), H(50))];
    [taskBtn addTarget:self action:@selector(gotoEquipmentView) forControlEvents:UIControlEventTouchUpInside];
    [taskBtn setBackgroundImage:[ImageClip imageWithPngName:@"bg13"] forState:UIControlStateNormal];
    [taskBtn setImage:[ImageClip imageWithPngName:@"icon83"] forState:UIControlStateNormal];
    [taskBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 25, 5, 25)];
    [self.leftView addSubview:taskBtn];
    [UIView animateWithDuration:1.0 animations:^{
        self.leftView.frame = CGRectMake(W(0), H(80), W(140), H(300));
    }];
}

/**
 *  创建下方视图
 */
-(void)createDownWindowUI{
    self.downView = [[UIView alloc]initWithFrame:CGRectMake(0, WinHeight, WinWidth, H(80))];
    [self.view addSubview:self.downView];
    //创建掷色子的按钮
    UIButton *startBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(5), 0, W(80), H(80))];
    [startBtn addTarget:self action:@selector(showDiceView:) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setBackgroundImage:[ImageClip imageWithPngName:@"bg14"] forState:UIControlStateNormal];
    [startBtn setImage:[ImageClip imageWithPngName:@"icon0"] forState:UIControlStateNormal];
    [startBtn setImageEdgeInsets:UIEdgeInsetsMake(H(10), W(10), H(10), W(10))];
    [self.downView addSubview:startBtn];
    //创建使用物品按钮
    CGFloat width = (WinWidth-W(30)-W(80))/4;
    UIButton *thingBtn = [[UIButton alloc]initWithFrame:CGRectMake(W(90), H(80)-width,width, width)];
    [thingBtn addTarget:self action:@selector(gotoUsingThingsView) forControlEvents:UIControlEventTouchUpInside];
    [thingBtn setBackgroundImage:[ImageClip imageWithPngName:@"bg14"] forState:UIControlStateNormal];
    [thingBtn setImage:[ImageClip imageWithPngName:@"icon40"] forState:UIControlStateNormal];
    [thingBtn setImageEdgeInsets:UIEdgeInsetsMake(H(5), W(5), H(5), W(5))];
    [self.downView addSubview:thingBtn];
    //创建事件按钮
    CGFloat x = thingBtn.frame.origin.x + W(5) + width;
    UIButton *messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(x,H(80)-width,width, width)];
    [messageBtn addTarget:self action:@selector(gotoEventTableView) forControlEvents:UIControlEventTouchUpInside];
    [messageBtn setBackgroundImage:[ImageClip imageWithPngName:@"bg14"] forState:UIControlStateNormal];
    [messageBtn setImage:[ImageClip imageWithPngName:@"icon62"] forState:UIControlStateNormal];
    [messageBtn setImageEdgeInsets:UIEdgeInsetsMake(H(5), W(5), H(5), W(5))];
    [self.downView addSubview:messageBtn];
    //创建存档按钮
    x = messageBtn.frame.origin.x + W(5) + width;
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, H(80)-width,width, width)];
    [saveBtn addTarget:self action:@selector(gotoSaveGameView) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setBackgroundImage:[ImageClip imageWithPngName:@"bg14"] forState:UIControlStateNormal];
    [saveBtn setImage:[ImageClip imageWithPngName:@"icon78"] forState:UIControlStateNormal];
    [saveBtn setImageEdgeInsets:UIEdgeInsetsMake(H(5), W(5), H(5), W(5))];
    [self.downView addSubview:saveBtn];
    //创建帮助按钮
    x = saveBtn.frame.origin.x + W(5) + width;
    UIButton *helpBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, H(80)-width,width, width)];
    [helpBtn addTarget:self action:@selector(gotoHelpView) forControlEvents:UIControlEventTouchUpInside];
    [helpBtn setBackgroundImage:[ImageClip imageWithPngName:@"bg14"] forState:UIControlStateNormal];
    [helpBtn setImage:[ImageClip imageWithPngName:@"icon72"] forState:UIControlStateNormal];
    [helpBtn setImageEdgeInsets:UIEdgeInsetsMake(H(5), W(5), H(5), W(5))];
    [self.downView addSubview:helpBtn];
    
    
    [UIView animateWithDuration:1.0 animations:^{
        self.downView.frame = CGRectMake(0, WinHeight-H(80), WinWidth, H(80));
    }];
}

/**
 *  隐藏或显示左侧边栏
 */
-(void)showOrHideLeftUI{
    if (self.leftView.frame.origin.x<0) {
        [UIView animateWithDuration:1.0 animations:^{
            self.leftView.frame = CGRectMake(W(0), H(80), W(140), H(300));
        }];
    }else{
        [UIView animateWithDuration:1.0 animations:^{
            self.leftView.frame = CGRectMake(-W(120), H(80), W(140), H(300));
        }];
    }
}

/**
 *  刷新血量的显示
 */
-(void)reloadHPView{
    if (self.hpView) {
        CGFloat scale = [self.gameSave.characterModel.currentBlood doubleValue]/[self.gameSave.characterModel.blood doubleValue];
        CGFloat width = scale*W(209);
        [UIView animateWithDuration:2.0 animations:^{
            self.hpView.frame = CGRectMake(W(25), H(0), width, H(24));
        }];
        if (scale>=0.8) {
            self.hpView.backgroundColor = [UIColor greenColor];
        }
        else if (scale>=0.5) {
            self.hpView.backgroundColor = [UIColor colorWithRed:1.000 green:0.714 blue:0.028 alpha:1.000];
        }else{
            self.hpView.backgroundColor = [UIColor redColor];
        }
    }
    if (self.hpLabel) {
        self.hpLabel.textAlignment = NSTextAlignmentCenter;
        self.hpLabel.text = [NSString stringWithFormat:@"%@/%@",self.gameSave.characterModel.currentBlood,self.gameSave.characterModel.blood];
    }
}

/**
 *  刷新行动力的显示
 */
-(void)reloadActiveView{
    if (self.activeView) {
        CGFloat scale = [self.gameSave.characterModel.power doubleValue]/100;
        CGFloat width = scale * W(121);
        [UIView animateWithDuration:2.0 animations:^{
            self.activeView.frame = CGRectMake(W(25), W(0), width, H(24));
        }];
        if (scale>=0.8) {
            self.activeView.backgroundColor = [UIColor blueColor];
        }
        else if (scale>=0.5) {
            self.activeView.backgroundColor = [UIColor colorWithRed:0.308 green:0.419 blue:1.000 alpha:1.000]
            ;
        }else{
            self.activeView.backgroundColor = [UIColor colorWithRed:0.436 green:1.000 blue:0.882 alpha:1.000];
        }
    }
    if (self.activeLabel) {
        self.activeLabel.textAlignment = NSTextAlignmentCenter;
        self.activeLabel.text = [NSString stringWithFormat:@"%@/%@",self.gameSave.characterModel.power,@100];
    }
}

/**
 *  由存档名创建控制器
 */
-(instancetype)initWithSave:(Save *)save{
    if (self = [super init]) {
        self.gameSave = save;
        self.map = [[Map alloc]getMapByName:save.mapName];
        UIImage *mapImage = [ImageClip imageWithPngName:self.map.mapName];
        self.mapView = [[ScrollMapView alloc]initWithMapImage:mapImage];
        self.mapView.frame = [UIScreen mainScreen].bounds;
        self.mapView.mapMoveArray = self.map.mapPassArr;
        self.mapView.delegate = self;
        [self.mapView CharacterWithLocation:CGPointMake([save.characterPointX intValue], [save.characterPointY intValue]) withCharacterDirection:[CharacterMove changeNumberToDirection:save.direction] withCharacterImageName:save.characterModel.animationImage];
        self.mapView.contentOffset = CGPointMake([save.mapOffSetX intValue],[save.mapOffSetY intValue]);
        self.mapView.character.contentOffset = self.mapView.contentOffset;
    }
    return self;
}

/**
 *  弹出掷点视图
 */
-(void)showDiceView:(UIButton *)button{
    int power = [self.gameSave.characterModel.power intValue];
    if (power > 80) {
        self.diceView = [DiceView diceViewWithTotalNumber:@3];
    }else if(power >50){
        self.diceView = [DiceView diceViewWithTotalNumber:@2];
    }else if(power >0){
        self.diceView = [DiceView diceViewWithTotalNumber:@1];
    }
    if (power>2) {
        self.leftView.userInteractionEnabled = NO;
        self.downView.userInteractionEnabled = NO;
        self.diceView.center = CGPointMake(WinWidth/2, WinHeight/2);
        self.diceView.delegate = self;
        [self.view addSubview:self.diceView];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"体力值过低，请用道具补充" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
}

/**
 *  色子停止时取到结果
 */
-(void)DiceViewStopWithResult:(NSNumber *)resultNum{
    [self performSelector:@selector(removeDiceView:) withObject:@{@"result":resultNum} afterDelay:1.0];
}

/**
 *  移除色子的视图
 */
-(void)removeDiceView:(NSSet *)objects{
    [UIView animateWithDuration:2.0 delay:3.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [self.diceView removeFromSuperview];
    } completion:^(BOOL finished) {
        [self.mapView moveWithStepNum:[(NSDictionary *)objects objectForKey:@"result"]];
    }];
}

/**
 *  代理方法---行走完成
 */
-(void)ScrollMapViewMoveStopAtPoint:(CGPoint)point{
    //增加携带武将体力值，减少自身的行动值,增加自己通过税收获得的钱
    [self changeValueWhenStop];
    //得到事件数组值
    int row = point.y/32;
    int col = point.x/32;
    int number = row * (self.mapView.map.frame.size.width/32)+col;
    //如果有事件则触发事件
    if ([self.mapEventArr[number] integerValue]>100) {
        EventManager *event = [[EventManager alloc]init];
        [event passEventWithNumber:self.mapEventArr[number] withSave:self.gameSave withViewController:self];
    }else{
        //否则是否触发随机事件
        RandomEventManager *random = [[RandomEventManager alloc]init];
        random.delegate = self;
        [random passEventWithNumber:self.mapEventArr[number] withSave:self.gameSave withViewController:self];
    }
    //游戏结束判定
    
    self.leftView.userInteractionEnabled = YES;
    self.downView.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  增加携带武将体力值，减少自身的行动值,增加自己通过税收获得的钱
 */
-(void)changeValueWhenStop{
    for (GeneralModel *general in self.gameSave.characterModel.carryingGeneral) {
        int power = [general.power intValue]+10;
        if (power>100) {
            power = 100;
        }
        general.power = [NSNumber numberWithInt:power];
    }
    CGFloat money = [self.gameSave.characterModel.money doubleValue];
    for (CityModel *city in self.gameSave.characterModel.havingCities) {
        money = money + [[city.output valueForKey:@"number"] doubleValue];
    }
    self.gameSave.characterModel.money = [NSNumber numberWithDouble:money];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@",self.gameSave.characterModel.money];
    int power = [self.gameSave.characterModel.power intValue];
    power = power - 2;
    if (power<0) {
        power = 0;
    }
    self.gameSave.characterModel.power = [NSNumber numberWithInt:power];
    [self reloadActiveView];
}

/**
 *  代理方法传递事件
 */
-(void)randomEventManagerPassEventMessage:(NSString *)msg{
    [self.record acceptEvent:msg];
}



/**
 *  跳转到存档视图的方法
 */
-(void)gotoSaveGameView{
    self.gameSave.characterPointX = [NSNumber numberWithInt:self.mapView.character.currentPoint.x];
    self.gameSave.characterPointY = [NSNumber numberWithInt:self.mapView.character.currentPoint.y];
    self.gameSave.mapOffSetX = [NSNumber numberWithInt:self.mapView.character.contentOffset.x];
    self.gameSave.mapOffSetY = [NSNumber numberWithInt:self.mapView.character.contentOffset.y];
    self.gameSave.direction = [CharacterMove changeDirectionToNumber:self.mapView.character.characterDirection];
    self.gameSave.mapName = self.map.mapName;
    SaveGameTableViewController *saveController = [[SaveGameTableViewController alloc]initWithSave:self.gameSave];
    KKNavigationController *kkController = [[KKNavigationController alloc]initWithRootViewController:saveController];
    [self presentViewController:kkController animated:YES completion:^{
        
    }];
}

/**
 *  跳转到个人信息的方法
 */
-(void)gotoCharacterMagView{
    CharacterMsgViewController *characterController = [[CharacterMsgViewController alloc]initWithSave:self.gameSave];
    KKNavigationController *kkController = [[KKNavigationController alloc]initWithRootViewController:characterController];
    [self presentViewController:kkController animated:YES completion:^{
        
    }];
}

/**
 *  跳转到武将信息的方法
 */
-(void)gotoGeneralMsgView{
    GeneralMsgTableViewController *generalController = [[GeneralMsgTableViewController alloc]initWithSave:self.gameSave];
    KKNavigationController *kkController = [[KKNavigationController alloc]initWithRootViewController:generalController];
    [self presentViewController:kkController animated:YES completion:^{
        
    }];
}

/**
 *  跳转到城市列表的方法
 */
-(void)gotoCityMsgView{
    CityMsgTableViewController *cityController = [[CityMsgTableViewController alloc]initWithSave:self.gameSave];
    KKNavigationController *kkController = [[KKNavigationController alloc]initWithRootViewController:cityController];
    [self presentViewController:kkController animated:YES completion:^{
        
    }];
}

/**
 *  跳转到帮助
 */
-(void)gotoHelpView{
    HelpViewController *helpController = [[HelpViewController alloc]init];
    KKNavigationController *kkController = [[KKNavigationController alloc]initWithRootViewController:helpController];
    [self presentViewController:kkController animated:YES completion:^{
        
    }];
}

/**
 *  跳转到事件列表
 */
-(void)gotoEventTableView{
    EventTableViewController *eventController = [[EventTableViewController alloc]initWithEventsList:self.record];
    KKNavigationController *kkController = [[KKNavigationController alloc]initWithRootViewController:eventController];
    [self presentViewController:kkController animated:YES completion:^{
        
    }];
}

/**
 *  跳转到装备列表
 */
-(void)gotoEquipmentView{
    EquipmentViewController *eventController = [[EquipmentViewController alloc]initWithSave:self.gameSave];
    KKNavigationController *kkController = [[KKNavigationController alloc]initWithRootViewController:eventController];
    [self presentViewController:kkController animated:YES completion:^{
        
    }];
}

/**
 *  跳转到物品列表
 */
-(void)gotoPackageView{
    BackpackViewController *backController = [[UIStoryboard storyboardWithName:@"backpack" bundle:nil]instantiateViewControllerWithIdentifier:@"backpackVC"];
    [backController packageWithSavedata:self.gameSave];
    KKNavigationController *kkController = [[KKNavigationController alloc]initWithRootViewController:backController];
    [self presentViewController:kkController animated:YES completion:^{
        
    }];
}

/**
 *  跳转到使用物品列表
 */
-(void)gotoUsingThingsView{
    UsingThingsTBVC *thingsVC = [[UIStoryboard storyboardWithName:@"usingThings" bundle:nil]instantiateViewControllerWithIdentifier:@"UsingThingsTBVC"];
    [thingsVC usingThingWithSavedata:self.gameSave];
    KKNavigationController *kkController = [[KKNavigationController alloc]initWithRootViewController:thingsVC];
    [self presentViewController:kkController animated:YES completion:^{
        
    }];
}

/**
 *  战斗代理
 */
-(void)battleViewPassMessage:(NSString *)message withResult:(NSNumber *)result{
    BattleResultViewController *battleResult = [[BattleResultViewController alloc]initWithMessage:message withResult:result withView:self.view];
    [self presentViewController:battleResult animated:NO completion:^{
    }];
}

-(void)cityEventDelegatePassSave:(Save *)save withCity:(CityModel *)city withGeneral:(GeneralModel *)general withSoldierNum:(NSNumber *)number{
    AttackCityBattleViewController *attack = [[AttackCityBattleViewController alloc]initWithSave:save andCityModel:city andAtkGeneral:general andSoliderNum:number];
    attack.delegate = self;
    [self presentViewController:attack animated:NO completion:^{
    }];
}
@end
