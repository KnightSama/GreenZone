//
//  HelpViewController.m
//  GreenZone
//
//  Created by niit on 15-7-6.
//  Copyright (c) 2015年 student. All rights reserved.
//

#define WinWidth [UIScreen mainScreen].bounds.size.width
#define WinHeight [UIScreen mainScreen].bounds.size.height

#define W(x) WinWidth*x/320.0
#define H(y) WinHeight*y/568.0

#import "HelpViewController.h"
#import "AudioTool.h"
@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    self.title = @"游戏指引";
    
    
    NSString *battleStr = @"战斗：\n1.与怪物战斗：与怪物战斗时将会显示战斗和逃跑两个选项，选择战斗将会和怪物进行战斗，获胜会获得奖励，失败则会损失；选择逃跑则会脱离战斗，但是逃跑有几率出现损失。请考虑好双方战力后慎重做出选择。\n2.攻城战：攻城会计算玩家和守城方双方的战力，攻城成功会获得当前城市的所有权，攻城失败则会出现损失，请慎重考虑是否攻城。";
    NSString *cityStr = @"城市：\n1.拥有的城市：玩家对于拥有的城市可以进行工程建设、军事建设、人口建设和城市税收。工程建设将会花费金钱提升玩家在当前城市的威望；军事建设将会花费金钱提升当前城市的军事实力；人口建设将会花费金钱提升当前城市的征兵数量；调整城市税收将会消耗玩家威望，相对的玩家可以获取可观的金钱。请注意，威望值过低时，将会有几率丢失城市。\n2.非拥有的城市：不属于玩家的城市会对路过的玩家收过路费，玩家每次停留时将要选择交税还是攻城，属于玩家的城市可以派出武将和士兵驻守。";
    NSString *generalStr = @"武将：\n1.招募武将：玩家在冒险过程中将有几率遇到武将，武将有花钱招募和志愿加入两种。\n2.调遣武将：玩家拥有的武将可以派驻在自己的城中，也可以派出攻城，武将自身的资质越高，防守和攻击也就越擅长。\n3.武将成长：玩家对于自己拥有的武将可以训练、抚恤和解雇。训练武将会花费金钱提升武将的资质；抚恤会花费金钱提升武将的忠诚度；解雇武将可以把自己不满意的武将差遣走。请注意，武将忠诚度过低时将有几率叛逃。";
    NSString *thingStr = @"物品：\n1.武器与防具：玩家可以装备的武器最多为1把；玩家装备的防具也最多为1件。\n2.恢复性物品：玩家在冒险过程中有几率采集到野菜这种常见的补充体力的物品。玩家击败怪物时有几率获得道具。\n3.神奇物品：游戏中有许多功能神奇的物品，请玩家在游戏中体会吧。";
    NSString *uiStr = @"游戏方式：\n1.游戏方式：这是一个神奇的掷骰型RPG游戏，游戏地图元素众多，一共有十座城市，其中一座是玩家的城市，玩家从这里出发。玩家通过投掷骰子周游这个世界，每次掷骰都将会消耗2点体力。请注意，没有体力的话旅途就终结了哦。\n2.胜利条件：游戏一共有4个方式取胜，统治胜利、收集胜利、荣誉胜利、富豪胜利。统治胜利需要玩家占领所有的10座城市；收集胜利需要玩家募集到一定数量的武将；荣誉胜利需要玩家的城市威望达到一定数值；富豪胜利需要玩家拥有的金钱达到指定数额。\n3.失败条件：玩家血量为零或者无法再行动则会导致游戏失败，请玩家慎重考虑。\n4.保存游戏：游戏具备保存功能，请玩家记得存档哦。";
    self.infoList = @[battleStr,cityStr,generalStr,thingStr,uiStr];
    
    
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, W(50), H(35))];
    [rightBtn addTarget:self action:@selector(gotoBack) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"exitimage.png"] forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];

    self.navigationItem.rightBarButtonItem = right;
    [self createdUI];
}

-(void)viewWillAppear:(BOOL)animated{
    self.player = [AudioTool playMusic:@"eventList.mp3"];
    self.player.numberOfLoops = NSNotFound;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player stop];
}

//返回上层视图
-(void)gotoBack
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//创建视图
-(void)createdUI
{
    UIImageView *view = [[UIImageView alloc]initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor blackColor];
    view.userInteractionEnabled = YES;
    [self.view addSubview:view];
    
    UIImageView *bigImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, H(44), W(320), H(156))];
    bigImage.image = [UIImage imageNamed:@"bigImage.jpg"];
    [view addSubview:bigImage];
    

    UIView *showView = [[UIView alloc]initWithFrame:CGRectMake(0, H(200), W(320), H(40))];
    showView.backgroundColor = [UIColor colorWithRed:37/255.0 green:28/255.0 blue:11/255.0 alpha:1.0];
    showView.layer.cornerRadius = 50.0;
    UILabel *showLabel = [[UILabel alloc]initWithFrame:CGRectMake(W(60), H(2), W(200), H(36))];
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.backgroundColor = [UIColor colorWithRed:84/255.0 green:24/255.0 blue:5/255.0 alpha:1.0];
    showLabel.textColor = [UIColor whiteColor];
    showLabel.text = @"帮助目录";
    [showView addSubview:showLabel];
    [view addSubview:showView];
    
//    UISegmentedControl *kindSeg = [[UISegmentedControl alloc]initWithItems:@[@"战斗",@"武将",@"城市",@"物品",@"界面"]];
    UISegmentedControl *kindSeg = [[UISegmentedControl alloc]initWithItems:nil];
    [kindSeg insertSegmentWithTitle:@"战斗" atIndex:0 animated:NO];
    [kindSeg insertSegmentWithTitle:@"城市" atIndex:1 animated:NO];
    [kindSeg insertSegmentWithTitle:@"武将" atIndex:2 animated:NO];
    [kindSeg insertSegmentWithTitle:@"物品" atIndex:3 animated:NO];
    [kindSeg insertSegmentWithTitle:@"游戏方式" atIndex:4 animated:NO];
    kindSeg.frame = CGRectMake(0, H(240), W(320), H(29));
    kindSeg.selectedSegmentIndex = 0;
    [kindSeg addTarget:self action:@selector(segChanged:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:kindSeg];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, H(269), W(320), H(299))];
    _textView.backgroundColor = [UIColor colorWithRed:37/255.0 green:28/255.0 blue:11/255.0 alpha:1.0];
    _textView.textColor = [UIColor whiteColor];
    _textView.text = self.infoList[kindSeg.selectedSegmentIndex];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.editable = NO;
    [view addSubview:_textView];
    
    
}

-(void)segChanged:(id)sender
{
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    NSInteger index = seg.selectedSegmentIndex;
    self.textView.text = self.infoList[index];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
